From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Mar 2011 15:46:02 +0900
Subject: [PATCH] S3C64XX: Fix keypad setup to configure correct number of
	rows
In-Reply-To: <1299010582-32481-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1299010582-32481-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <010a01cbd8a5$83211d20$89635760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> From: Ben Dooks <ben-linux@fluff.org>
> 
> The call to s3c_gpio_cfgrange_nopull() takes a size and base
> but this looks like it is trying to do base and end. This means
> it is configuring too many GPIOs and on the case of the Cragganmore
> means we're seeing an overflow of the ROW pins causing problems
> with the keyboard driver.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-s3c64xx/setup-keypad.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-
> s3c64xx/setup-keypad.c
> index f8ed0d2..1d4d0ee 100644
> --- a/arch/arm/mach-s3c64xx/setup-keypad.c
> +++ b/arch/arm/mach-s3c64xx/setup-keypad.c
> @@ -17,7 +17,7 @@
>  void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
>  {
>  	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x]
*/
> -	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), 8 + rows, S3C_GPIO_SFN(3));
> +	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), rows, S3C_GPIO_SFN(3));
> 
>  	/* Set all the necessary GPL pins to special-function 3: KP_COL[x]
*/
>  	s3c_gpio_cfgrange_nopull(S3C64XX_GPL(0), cols, S3C_GPIO_SFN(3));
> --
> 1.7.2.3

Oops, you're right.

Applied into s5p-fixes-for-linus for 38.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
