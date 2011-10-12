From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Oct 2011 21:43:01 +0900
Subject: [PATCH v2] ARM: EXYNOS4: Add support for M-5MOLS camera on Nuri
	board
References: <034f01cc8705$199b0dc0$4cd12940$%kim@samsung.com>
	<1318238959-28012-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <069701cc88dc$7a484100$6ed8c300$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Sylwester Nawrocki wrote:
> >
> > Add voltage regulator and platform data definition for M-5MOLS sensor
> > and MIPI-CSI receiver drivers. Add CAM power domain dependencies for
> > FIMC device and set up camera port A GPIO. Configure I2C0 bus timings.
> >
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > Signed-off-by: HeungJun Kim <riverful.kim@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > Hi Kgene,
> >
> > I have corrected the white space issues as you pointed out and removed
> > unnecessary gpio_free() in this patch.
> >
> > Thanks,
> >  Sylwester
> > ---
> >  arch/arm/mach-exynos4/Kconfig     |    8 ++
> >  arch/arm/mach-exynos4/mach-nuri.c |  156
> > +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 164 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos4/Kconfig
b/arch/arm/mach-exynos4/Kconfig
> > index dd660eb..4bc4b1f 100644
> > --- a/arch/arm/mach-exynos4/Kconfig
> > +++ b/arch/arm/mach-exynos4/Kconfig

(snip)

> > +static struct s5p_platform_fimc fimc_md_platdata = {
> > +	.isp_info	= nuri_camera_sensors,
> > +	.num_clients	= ARRAY_SIZE(nuri_camera_sensors),
> > +};

Hi Sylwester,

You need to move 'struct platform_device s5p_device_fimc_md' to
plat-samsung/devs.c or add 'static' because following error is happened.

arch/arm/mach-exynos4/mach-nuri.o: In function `  CC      kernel/sysctl.o
.LANCHOR1':
mach-nuri.c:(.data+0x38): multiple definition of `s5p_device_fimc_md'
arch/arm/mach-exynos4/mach-universal_c210.o:mach-universal_c210.c:(.data+0x1
8): first defined here
make[2]: *** [arch/arm/mach-exynos4/built-in.o] Error 1
make[1]: *** [arch/arm/mach-exynos4] Error 2
make[1]: *** Waiting for unfinished jobs....

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
