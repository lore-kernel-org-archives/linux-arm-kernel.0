From: sanjay.rawat@linaro.org (Sanjay Singh Rawat)
Date: Tue, 04 Jun 2013 20:50:35 +0530
Subject: [PATCH 2/8] ARM: RealView: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-3-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-3-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <51AE05C3.2090404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

can you please review this patch?

On Monday 27 May 2013 08:02 PM, Sanjay Singh Rawat wrote:
> use cpu_do_idle for entering the wfi mode
>
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>   arch/arm/mach-realview/hotplug.c |    9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
> index ac22dd4..c42022b 100644
> --- a/arch/arm/mach-realview/hotplug.c
> +++ b/arch/arm/mach-realview/hotplug.c
> @@ -59,13 +59,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   	 * code will have already disabled interrupts
>   	 */
>   	for (;;) {
> -		/*
> -		 * here's the WFI
> -		 */
> -		asm(".word	0xe320f003\n"
> -		    :
> -		    :
> -		    : "memory", "cc");
> +		/* enter WFI mode */
> +		cpu_do_idle();
>
>   		if (pen_release == cpu_logical_map(cpu)) {
>   			/*
>
