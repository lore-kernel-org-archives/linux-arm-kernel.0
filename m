From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:22:43 +0200
Subject: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
In-Reply-To: <20160415123941.GD3589@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec> <20160415123941.GD3589@x1>
Message-ID: <20160415142243.GE3472@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 01:39:41PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> 
> > On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> > [...]
> > > +struct sti_cpt_data {
> > > +	u32 snapshot[3];
> > > +	int index;
> > > +	int gpio;
> > 
> > On a side-note, this should probably use struct gpio_desc * instead of
> > an integer along with the gpiod_*() APIs for the GPIO handling.
> 
> Why would you need to do that?
> 
> of_get_named_gpio() does all that for you.

Use the of_get_named_gpio*d*() function instead. My understanding is
that referring to GPIOs by integer is deprecated and should not be used
in new code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/b8ca5610/attachment.sig>
