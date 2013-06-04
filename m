From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Tue, 04 Jun 2013 20:53:09 +0530
Subject: [PATCH 4/8] ARM: vexpress: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-5-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-5-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <51AE065D.7010506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello Russell, Nicolas,

can you please review this patch?


On Monday 27 May 2013 08:02 PM, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the wfi mode.
>
> Signed-off-by: Sanjay Singh Rawat<sanjay.rawat@linaro.org>
> ---
>   arch/arm/mach-vexpress/hotplug.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> index f0ce6b8..b3dffc2 100644
> --- a/arch/arm/mach-vexpress/hotplug.c
> +++ b/arch/arm/mach-vexpress/hotplug.c
> @@ -60,7 +60,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   	 * code will have already disabled interrupts
>   	 */
>   	for (;;) {
> -		wfi();
> +		/* enter WFI mode */
> +		cpu_do_idle();
>
>   		if (pen_release == cpu_logical_map(cpu)) {
>   			/*
