From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 23:10:21 +0900
Subject: [PATCH 1/3] ARM: mach-shmobile: mackerel: enable REGULATOR in
 defconfig
In-Reply-To: <Pine.LNX.4.64.1302131418350.18535@axis700.grange>
References: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
 <1360761103-17357-2-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1302131418350.18535@axis700.grange>
Message-ID: <20130213141021.GC30293@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 02:21:53PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 13 Feb 2013, Simon Horman wrote:
> 
> > As well as being a generally sane thing to do this
> > is required for MMCIF to function in conjunction with
> > " ARM: shmobile: streamline mackerel SD and MMC devices".
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > 
> > v2
> > * Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
> > ---
> >  arch/arm/configs/mackerel_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
> > index ec8e605..9fb1189 100644
> > --- a/arch/arm/configs/mackerel_defconfig
> > +++ b/arch/arm/configs/mackerel_defconfig
> > @@ -75,6 +75,7 @@ CONFIG_I2C=y
> >  CONFIG_I2C_SH_MOBILE=y
> >  # CONFIG_HWMON is not set
> >  # CONFIG_MFD_SUPPORT is not set
> > +CONFIG_REGULATOR=y
> 
> We really don't have to enable CONFIG_REGULATOR_GPIO and 
> CONFIG_REGULATOR_FIXED_VOLTAGE? IIRC, CONFIG_REGULATOR_GPIO is so far only 
> used on armadillo800eva, but the fixed regulator is required for other 
> boards too?

The Kconfig for MACH_ARMADILLO800EVA selects REGULATOR_FIXED_VOLTAGE is
REGULATOR is enabled.

Likewise for kzm9g, mackerel and a bunch of other boards.
