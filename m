From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 23 Apr 2016 00:30:49 +0200
Subject: [PATCH v2] drm/panel: simple: Add support for Innolux AT070TN92
In-Reply-To: <877ffrp3fc.fsf@gmail.com>
References: <1461159435-16528-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160420134036.GA7470@ulmo.ba.sec> <877ffrp3fc.fsf@gmail.com>
Message-ID: <20160422223047.GA22161@mithrandir.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 02:11:19PM +0200, Holger Schurig wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
> > Applied, thanks.
> 
> I once read that this is the recommended way to go, instead of
> specifying the timings in the device tree. Why is this so?  Any new
> display just increases the .text size of the kernel unnessary.

It's actually only the .rodata section that's increased every time we
add a new display panel.

> Did this idea stem from the era where bootloaders like Barebox couldn't
> modify the DT ad-hoc before handing it over to the kernel?

No, not really. But since this has come up every now and again I finally
wrote down my recollection and thoughts on the matter, hopefully that
will be satisfactory as an answer:

	http://sietch-tagr.blogspot.com/2016/04/display-panels-are-not-special.html

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160423/7be16892/attachment.sig>
