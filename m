From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 16:10:21 +0100
Subject: [PATCH v2 14/18] ARM: Add STM32 family machine
In-Reply-To: <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-15-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <2736580.bRymLWnSQl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 19:01:13 Maxime Coquelin wrote:
> +static void __init stm32_timer_init(void)
> +{
> +       of_clk_init(NULL);
> +       reset_controller_of_init();
> +       clocksource_of_init();
> +
> +}

Don't do that. As I said, I'd rather not introduce reset_controller_of_init()
at all, but if we end up doing it, it should be run by default for
any machine that has an empty timer_init callback.

	Arnd
