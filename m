From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 04 Nov 2011 14:02:16 +0900
Subject: [PATCH 3/3 v3.1] ARM: S3C64XX: Correct reservation of GPIOs for
	CPU module on Cragganmore
In-Reply-To: <20111103121014.GA11851@opensource.wolfsonmicro.com>
References: <1320086573-21184-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1320086573-21184-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<018d01cc99fc$8a2ee840$9e8cb8c0$%kim@samsung.com>
	<20111103121014.GA11851@opensource.wolfsonmicro.com>
Message-ID: <026d01cc9aae$ec554520$c4ffcf60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Thu, Nov 03, 2011 at 04:45:21PM +0900, Kukjin Kim wrote:
> > Mark Brown wrote:
> 
> > >  #define PCA935X_GPIO_BASE		GPIO_BOARD_START
> > >  #define CODEC_GPIO_BASE		(GPIO_BOARD_START + 8)
> > >  #define GLENFARCLAS_PMIC_GPIO_BASE	(GPIO_BOARD_START + 16)
> > > +#define BANFF_PMIC_GPIO_BASE
> > > 	(GLENFARCLAS_PMIC_GPIO_BASE + 16)
> 
> > Above definitions are at mach/crag6410.h file not mach-crag6410.c file
in my
> > tree.
> > And in my opinion, to use GPIO_BOARD_START is better than to use
> > GLENFARCLAS_PMIC_GPIO_BASE like others for easily reading.
> 
> I'd prefer it if the were all defined in terms of the preceeding one but
> yes.
> 
> > So I think, this should be following...?
> 
> Yes.

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
