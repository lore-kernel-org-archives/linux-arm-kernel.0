From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Apr 2014 16:28:04 +0200
Subject: [PATCHv2 5/8] ARM: EXYNOS: Support secondary CPU boot of
 Exynos3250
In-Reply-To: <1397527192-21988-6-git-send-email-cw00.choi@samsung.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <534E9374.6010807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 15.04.2014 03:59, Chanwoo Choi wrote:
> This patch fix the offset of CPU boot address and don't operate smc call
> of SMC_CMD_CPU1BOOT command for Exynos3250.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-exynos/firmware.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
> index aa01c42..6205d4f 100644
> --- a/arch/arm/mach-exynos/firmware.c
> +++ b/arch/arm/mach-exynos/firmware.c
> @@ -30,13 +30,16 @@ static int exynos_do_idle(void)
>
>   static int exynos_cpu_boot(int cpu)
>   {
> +	if (soc_is_exynos3250()) {
> +		return 0;

This is strange. How the firmware knows when to boot the CPU then, if 
CPU1BOOT command is not called?

Best regards,
Tomasz
