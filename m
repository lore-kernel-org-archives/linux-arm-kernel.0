From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 Mar 2015 10:27:55 +0100
Subject: [PATCH resend v4] phy: Add driver to support individual USB PHYs
 on sun9i
In-Reply-To: <CAGb2v654YEDuRSi-RDf-3E6EnTkQpTEPJim=CtXMKe2j=1P3mA@mail.gmail.com>
References: <1426154079-423-1-git-send-email-wens@csie.org>
 <5502858D.2060102@ti.com>
 <CAGb2v654YEDuRSi-RDf-3E6EnTkQpTEPJim=CtXMKe2j=1P3mA@mail.gmail.com>
Message-ID: <20150313092754.GQ5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:24:14PM +0800, Chen-Yu Tsai wrote:
> >> +       phy->vbus = devm_regulator_get_optional(dev, "vbus");
> >
> >
> > Looks like vbus-supply is not documented in the binding documentation.
> > However you can use the phy-supply from the generic binding so that phy-core
> > can handle the regulator enable/disable.
> 
> I'll add this one to the bindings because a) the DTS files using them are
> already in Maxime's tree and b) try to keep it similar to phy-usb-sun4i.
> 
> Of course if people think it's OK, I can send a patch changing the DTS
> file, which itself is queued for 4.1, and drop all the regulator code
> from the phy driver. :)
> 
> Maxime?

Sounds like a good plan :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150313/096ff734/attachment-0001.sig>
