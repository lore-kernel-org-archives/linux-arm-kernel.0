From: horms@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 22:12:13 +0900
Subject: [PATCH] ARM: mach-shmobile: armadillo800eva: enable REGULATOR in
 defconfig
In-Reply-To: <Pine.LNX.4.64.1302131324200.18535@axis700.grange>
References: <1360757745-15251-1-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1302131324200.18535@axis700.grange>
Message-ID: <20130213131213.GJ22623@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 01:26:55PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 13 Feb 2013, Simon Horman wrote:
> 
> > As well as being a generally sane thing to do this
> > is required for MMCIF to function in conjunction with
> > "ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva".
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/configs/armadillo800eva_defconfig |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> > index 0b98100..6ceb79f 100644
> > --- a/arch/arm/configs/armadillo800eva_defconfig
> > +++ b/arch/arm/configs/armadillo800eva_defconfig
> > @@ -88,6 +88,8 @@ CONFIG_I2C=y
> >  CONFIG_I2C_GPIO=y
> >  CONFIG_I2C_SH_MOBILE=y
> >  # CONFIG_HWMON is not set
> > +CONFIG_REGULATOR=y
> > +CONFIG_REGULATOR_DUMMY=y
> 
> I don't think it's a good idea to enable the dummy regulator by default in 
> defconfig. It has been explained to me, that that regulator is only meant 
> for development / testing. For production you really should have the 
> _correct_ regulators in place. So, encouraging it by default is probably 
> not a very good idea.

Thanks, I will fix up this and the other defconfigs accordingly.
