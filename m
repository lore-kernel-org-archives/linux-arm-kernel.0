From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:02:14 +0100
Subject: [PATCH v2 07/18] drivers: reset: Add STM32 reset driver
In-Reply-To: <1424455277-29983-8-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-8-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <2383270.cAJPOxrkvo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 19:01:06 Maxime Coquelin wrote:
> +/* AHB1 */
> +#define GPIOA_RESET    0
> +#define GPIOB_RESET    1
> +#define GPIOC_RESET    2
> +#define GPIOD_RESET    3
> +#define GPIOE_RESET    4
> +#define GPIOF_RESET    5
> +#define GPIOG_RESET    6
> +#define GPIOH_RESET    7
> +#define GPIOI_RESET    8
> +#define GPIOJ_RESET    9
> +#define GPIOK_RESET    10
> 

As these are just the hardware numbers, it's better to not make them
part of the binding at all. Instead, just document in the binding that
one is supposed to pass the hardware number as the argument.

	Arnd
