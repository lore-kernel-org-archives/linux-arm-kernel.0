From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Sep 2012 13:19:41 +0000
Subject: [PATCH V4 4/6] arm: mvebu: add L2 cache support
In-Reply-To: <1348213574-18494-5-git-send-email-gregory.clement@free-electrons.com>
References: <1348213574-18494-1-git-send-email-gregory.clement@free-electrons.com>
 <1348213574-18494-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201209211319.41879.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 September 2012, Gregory CLEMENT wrote:
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> @@ -130,4 +131,7 @@ static const struct of_device_id mpic_of_match[] __initconst = {
>  void __init armada_370_xp_init_irq(void)
>  {
>         of_irq_init(mpic_of_match);
> +#ifdef CONFIG_CACHE_L2X0
> +       l2x0_of_init(0, ~0UL);
> +#endif
>  }

But you can leave out the #ifdef. l2x0_of_init is already defined as an empty
function if either CONFIG_OF or CONFIG_L2X0 is disabled.

	Arnd
