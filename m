From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Feb 2014 23:52:48 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <20140213082630.GA3119@katana>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana>
Message-ID: <20140213225248.GB15350@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 09:26:30AM +0100, Wolfram Sang wrote:
> 
> Why is the devicetree list not on CC? (Added now)
> 
> On Thu, Feb 06, 2014 at 10:51:25AM +0100, Maxime Ripard wrote:
> > Switch the device tree to the new compatibles introduced in the i2c drivers
> > to have a common pattern accross all Allwinner SoCs.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
> >  arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
> >  arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
> >  arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
> >  4 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> > index 28273f9..ac65c8a 100644
> > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > @@ -518,7 +518,7 @@
> >  		};
> >  
> >  		i2c0: i2c at 01c2ac00 {
> > -			compatible = "allwinner,sun4i-i2c";
> > +			compatible = "allwinner,sun4i-a10-i2c";
> 
> Can't we have:
> 
> 	compatible = "allwinner,sun4i-a10-i2c", "allwinner,sun4i-i2c";
> 
> ? And keep the old "allwinner,sun4i-i2c" and extend it with a SoC
> specific a10 compatible entry when a distinction is needed?

Actually, the two are exactly equivalent. The point is that the
compatible naming scheme doesn't follow what we are using (which is
<family>-<soc>-i2c), so we wan't to get rid of the old naming scheme
all together.

> > diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> > index 6de40b6..537072c 100644
> > --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> > +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> > @@ -377,7 +377,7 @@
> >  		};
> >  
> >  		i2c0: i2c at 01c2ac00 {
> > -			compatible = "allwinner,sun4i-i2c";
> > +			compatible = "allwinner,sun4i-a10-i2c";
> 
> For non-a10, That should be at least
> 
> 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
> 
> or
> 
> 	compatible = "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
> 
> depending on the outcome above.
> 
> Or is my knowledge outdated already?
> 

Since they are strictly compatible, we don't need to introduce any
different compatible string here.


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/e625a811/attachment.sig>
