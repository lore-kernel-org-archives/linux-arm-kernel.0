From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sat, 18 Feb 2012 19:56:30 +0400
Subject: [PATCH] arm: smp-twd: check for uninitialized clock in
 twd_cpufreq_init
In-Reply-To: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
References: <1329474869-32356-1-git-send-email-t-kristo@ti.com>
Message-ID: <4F3FCA2E.3000804@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-02-2012 14:34, Tero Kristo wrote:

> Non-smp platforms don't have local timer support, but the twd_cpufreq_init
> only checks for IS_ERR during init. Check against null also, to avoid
> crashes during cpufreq transitions on non-smp platforms.

> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   arch/arm/kernel/smp_twd.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 4285daa..dae8902 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -129,7 +129,7 @@ static struct notifier_block twd_cpufreq_nb = {
>
>   static int twd_cpufreq_init(void)
>   {
> -	if (!IS_ERR(twd_clk))
> +	if (twd_clk&&  !IS_ERR(twd_clk))

    Why not !IS_ERR_OR_NULL(twd_clk)?

WBR, Sergei
