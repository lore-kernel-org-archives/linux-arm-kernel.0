From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 28 May 2013 15:25:16 +0530
Subject: [PATCH 3/8] ARM: SPEAr: use generic cpu idle function for wfi
In-Reply-To: <1369665166-13049-4-git-send-email-sanjay.rawat@linaro.org>
References: <1369665166-13049-1-git-send-email-sanjay.rawat@linaro.org>
 <1369665166-13049-4-git-send-email-sanjay.rawat@linaro.org>
Message-ID: <CAKohpo=dVM_gd31h3sG0d0_hKcCfaHLtwfF3RXL453bE9K+L2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2013 20:02, Sanjay Singh Rawat <sanjay.rawat@linaro.org> wrote:
> use cpu_do_idle for entering the wfi mode.
>
> Signed-off-by: Sanjay Singh Rawat <sanjay.rawat@linaro.org>
> ---
>  arch/arm/mach-spear/hotplug.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-spear/hotplug.c b/arch/arm/mach-spear/hotplug.c
> index d97749c..6dbd3dc 100644
> --- a/arch/arm/mach-spear/hotplug.c
> +++ b/arch/arm/mach-spear/hotplug.c
> @@ -55,7 +55,8 @@ static inline void cpu_leave_lowpower(void)
>  static inline void spear13xx_do_lowpower(unsigned int cpu, int *spurious)
>  {
>         for (;;) {
> -               wfi();
> +               /* enter WFI mode */
> +               cpu_do_idle();
>
>                 if (pen_release == cpu) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
