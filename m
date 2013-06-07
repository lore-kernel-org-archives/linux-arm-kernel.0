From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 07 Jun 2013 16:11:10 +0100
Subject: [PATCH 4/8] ARM: vexpress: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-5-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-5-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <1370617870.4852.23.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-27 at 15:32 +0100, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the wfi mode.
> 
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>  arch/arm/mach-vexpress/hotplug.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/mach-vexpress/hotplug.c
> index f0ce6b8..b3dffc2 100644
> --- a/arch/arm/mach-vexpress/hotplug.c
> +++ b/arch/arm/mach-vexpress/hotplug.c
> @@ -60,7 +60,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  	 * code will have already disabled interrupts
>  	 */
>  	for (;;) {
> -		wfi();
> +		/* enter WFI mode */
> +		cpu_do_idle();
>  
>  		if (pen_release == cpu_logical_map(cpu)) {
>  			/*

I probably don't get the whole picture, but may I ask what is the
rationale behind this change? As in: why cpu_do_idle() is better?

Pawe?
