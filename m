From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Apr 2016 14:24:03 +0100
Subject: [RESEND PATCH v2 7/7] usb: xhci: plat: add vbus regulator control
In-Reply-To: <20160427182516.36bd5fb5@xhacker>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-8-git-send-email-jszhang@marvell.com>
 <87bn4vpq7j.fsf@intel.com> <20160427095738.GG3217@sirena.org.uk>
 <20160427182516.36bd5fb5@xhacker>
Message-ID: <20160427132403.GN3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 06:25:16PM +0800, Jisheng Zhang wrote:
> On Wed, 27 Apr 2016 10:57:39 +0100 Mark Brown wrote:
> > On Wed, Apr 27, 2016 at 08:37:20AM +0300, Felipe Balbi wrote:

> > > > +	vbus = devm_regulator_get(&pdev->dev, "vbus");  

> > > devm_regulator_get_optional() ??  

> > Does USB work without a VBUS?  Unless the answer is yes then I'd expect
> > this to be just a normal regulator_get().

> Per spec no. But the vbus may be transparent to SW on some platforms, so I
> think devm_regulator_get_optional() is better.

Really, no.  If it's physically there the software needs to be written
as such.  Please see the documentation and list archives for extensive
discussion on this topic.

> > This is all completely broken unless the supply is optional.

> The supply is optional.

To repeat a supply is only optional if it might be physically absent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/5c7d5c8b/attachment.sig>
