From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 22:08:09 +0200
Subject: [PATCHv4] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <5267FE02.6000001@wwwdotorg.org>
References: <20131019104555.GI18477@ns203013.ovh.net>
 <1382346813-8449-1-git-send-email-denis@eukrea.com>
 <20131022045833.GB17512@ns203013.ovh.net>
 <20131022072307.GA8681@ulmo.nvidia.com>
 <20131022153445.GD17512@ns203013.ovh.net>
 <20131022200141.GA8037@mithrandir>
 <20131023134236.GE17512@ns203013.ovh.net>
 <5267FE02.6000001@wwwdotorg.org>
Message-ID: <20131023200808.GC8828@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 05:49:06PM +0100, Stephen Warren wrote:
> On 10/23/2013 02:42 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> ...
> > For me gpio_get_value can return the value of a an output gpio but this need
> > to be checked with LinusW
> 
> That's certainly not true for all possible GPIO controllers; there are
> at least some that can't read either:
> 
> * The value of the physical wire, if the GPIO is configured as an output.
> 
> * The value that the GPIO controller is driving as an output.

My point originally was that since it's an output pin, you need to
configure it as an output before you can use it. The way to do that in
Linux is to call gpio_direction_output(). But that will automatically
also force the output value to whatever you specify as the second
parameter.

I suppose that could be remedied by adding a separate function that
doesn't set the value, but as Stephen points out, reading the value of
an output pin may not be supported on all hardware.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/87631e74/attachment.sig>
