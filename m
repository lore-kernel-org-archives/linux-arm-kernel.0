From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 13:16:50 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <AANLkTi=Nxh8YKBSDhVVAW4Sqzd6yKj=D6X=R+9KT+UBK@mail.gmail.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
	<AANLkTi=Nxh8YKBSDhVVAW4Sqzd6yKj=D6X=R+9KT+UBK@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03112A5D7D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 23, 2011 2:08 PM:
> 
> On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > * Set up platform data required by I2C, and ASoC machine & codec drivers.
> > * Enable required GPIO pins as GPIOs.
> > * Initialize audio-related clocks.
> > * Correctly configure pinmux for audio-related GPIOs.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
> > ...
> > +#define GPIO_WM8903(_x_) ? ? ? ? ? ? ? (TEGRA_NR_GPIOS + (_x_))
> Can you name this HARMONY_GPIO_WM8903?

Sure. But then, wouldn't it make sense to also rename all the TEGRA_GPIO_*
below too?

> > +
> > ?#define TEGRA_GPIO_SD2_CD ? ? ? ? ? ? ?TEGRA_GPIO_PI5
> > ?#define TEGRA_GPIO_SD2_WP ? ? ? ? ? ? ?TEGRA_GPIO_PH1
> > ?#define TEGRA_GPIO_SD2_POWER ? ? ? ? ? TEGRA_GPIO_PT3
> > ?#define TEGRA_GPIO_SD4_CD ? ? ? ? ? ? ?TEGRA_GPIO_PH2
> > ?#define TEGRA_GPIO_SD4_WP ? ? ? ? ? ? ?TEGRA_GPIO_PH3
> > ?#define TEGRA_GPIO_SD4_POWER ? ? ? ? ? TEGRA_GPIO_PI6
> > +#define TEGRA_GPIO_CDC_IRQ ? ? ? ? ? ? TEGRA_GPIO_PX3
> > +#define TEGRA_GPIO_SPKR_EN ? ? ? ? ? ? GPIO_WM8903(2)
> > +#define TEGRA_GPIO_HP_DET ? ? ? ? ? ? ?TEGRA_GPIO_PW2
> > +#define TEGRA_GPIO_INT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX0
> > +#define TEGRA_GPIO_EXT_MIC_EN ? ? ? ? ?TEGRA_GPIO_PX1

-- 
nvpublic
