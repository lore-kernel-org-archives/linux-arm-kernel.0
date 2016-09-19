From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Sep 2016 13:50:54 +0200
Subject: [PATCH] ARM: mvebu: let Armada XP also select corediv clk
In-Reply-To: <1474276961-4645-1-git-send-email-u.kleine-koenig@pengutronix.de>
 ("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 19 Sep 2016
 11:22:41 +0200")
References: <1474276961-4645-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <87bmzk9kgx.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On lun., sept. 19 2016, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> An Armada XP there is also a marvell,armada-370-corediv-clock
> compatible device that is needed to make the nand device work.

Indeed when I acked the commit bd3677ff31a3 ("clk: mvebu: Remove corediv clock from
Armada XP") I missed that the armada-370-corediv-clock compatible sting
was for Armada 370 and Armada XP. We didn't see it until now because I
used the mvebu_v7_defconfig (or the multi_v7_defconfig) where all the
mvebu SoC are enabled.

But the Armada 39x also need it and actually all the SoC selecting
MVEBU_V7 config need this clock.

So I am sending a patch to fix it and it will part of the pull request
to arm-soc for the fix this week.

Thanks,

Gregory

>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index f9b6bd306cfe..2979a9c454f6 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -97,6 +97,7 @@ config MACH_ARMADA_XP
>  	select CPU_PJ4B
>  	select MACH_MVEBU_V7
>  	select PINCTRL_ARMADA_XP
> +	select MVEBU_CLK_COREDIV
>  	help
>  	  Say 'Y' here if you want your kernel to support boards based
>  	  on the Marvell Armada XP SoC with device tree.
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
