From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 10 Jan 2018 18:48:42 +0100
Subject: [PATCH 1/7] ARM: imx: add timer stop flag to ARM power off state
In-Reply-To: <20180102164223.15230-1-stefan@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
Message-ID: <1515606522.12538.44.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 02.01.2018, 17:42 +0100 schrieb Stefan Agner:
> When the CPU is in ARM power off state the ARM architected
> timers are stopped. The flag is already present in the higher
> power WAIT mode.
> 
> This allows to use the ARM generic timer on i.MX 6UL/6ULL SoC.
> Without the flag the kernel freezes when the timer enters the
> first time ARM power off mode.
> 
> Cc: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-
> imx/cpuidle-imx6sx.c
> index c5a5c3a70ab1..d0f14b761ff7 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> @@ -89,6 +89,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver
> = {
> ?			?*/
> ?			.exit_latency = 300,
> ?			.target_residency = 500,
> +			.flags = CPUIDLE_FLAG_TIMER_STOP,
> ?			.enter = imx6sx_enter_wait,
> ?			.name = "LOW-POWER-IDLE",
> ?			.desc = "ARM power off",
