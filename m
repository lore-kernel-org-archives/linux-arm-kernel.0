From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 22 Feb 2011 14:30:02 +0100
Subject: [PATCH 5/5] arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded
	values
In-Reply-To: <1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
Message-ID: <19811.47706.277301.848103@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> The latter are error-prone because the bank number is one less than one
> would read in the documentation.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric B?nard <eric@eukrea.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    4 ++--
>  arch/arm/mach-mx3/mach-cpuimx35.c            |    2 +-
>  arch/arm/mach-mx3/mach-pcm043.c              |   10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> index 14a5ffc..8076147 100644
> --- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> @@ -165,8 +165,8 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
>  	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
>  };
>  
> -#define GPIO_LED1	(2 * 32 + 29)
> -#define GPIO_SWITCH1	(2 * 32 + 25)
> +#define GPIO_LED1	IMX_GPIO_NR(3, 29)
> +#define GPIO_SWITCH1	IMX_GPIO_NR(3, 25)
>  #define GPIO_LCDPWR	(4)
>  
While you are at it you could also remove the nonsensical () around
the bare number.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
