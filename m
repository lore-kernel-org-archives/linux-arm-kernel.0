From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Feb 2011 17:20:24 +0900
Subject: [PATCH] ARM: S5P64X0: Modify number of GPIO lines in Bank F
In-Reply-To: <1298694349-16776-1-git-send-email-banajit.g@samsung.com>
References: <1298694349-16776-1-git-send-email-banajit.g@samsung.com>
Message-ID: <002401cbd720$5bfa3280$13ee9780$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Banajit Goswami wrote:
> 
> This patch modifies the number of total GPIO lines for Bank F
> for Samsung S5P6440 and S5P6450 SoCs from 2 to 16.
> This is necessary as the GPIO lines from 0 to 13 are reserved
> and only lines 14 and 15 are used. As during initialization,
> the line number starts at 0, putting 2 does not solve the
> intended purpose.
> 
> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/include/mach/gpio.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p64x0/include/mach/gpio.h b/arch/arm/mach-
> s5p64x0/include/mach/gpio.h
> index 5486c8f..adb5f29 100644
> --- a/arch/arm/mach-s5p64x0/include/mach/gpio.h
> +++ b/arch/arm/mach-s5p64x0/include/mach/gpio.h
> @@ -23,7 +23,7 @@
>  #define S5P6440_GPIO_A_NR	(6)
>  #define S5P6440_GPIO_B_NR	(7)
>  #define S5P6440_GPIO_C_NR	(8)
> -#define S5P6440_GPIO_F_NR	(2)
> +#define S5P6440_GPIO_F_NR	(16)
>  #define S5P6440_GPIO_G_NR	(7)
>  #define S5P6440_GPIO_H_NR	(10)
>  #define S5P6440_GPIO_I_NR	(16)
> @@ -36,7 +36,7 @@
>  #define S5P6450_GPIO_B_NR	(7)
>  #define S5P6450_GPIO_C_NR	(8)
>  #define S5P6450_GPIO_D_NR	(8)
> -#define S5P6450_GPIO_F_NR	(2)
> +#define S5P6450_GPIO_F_NR	(16)
>  #define S5P6450_GPIO_G_NR	(14)
>  #define S5P6450_GPIO_H_NR	(10)
>  #define S5P6450_GPIO_I_NR	(16)
> --

Ok, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
