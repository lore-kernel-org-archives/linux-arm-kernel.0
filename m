From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 25 Jun 2014 15:03:50 +0530
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <1403687412-22362-1-git-send-email-b20788@freescale.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
Message-ID: <CAOh2x=mgceoicULqEMXgto=F6GUNS8OLXs9i_k8FRrYyrVH8HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 2:40 PM, Anson Huang <b20788@freescale.com> wrote:
> Add cpufreq support for i.MX6SX, using common
> i.MX6Q cpufreq driver.
>
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/mach-imx/mach-imx6sx.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
> index 74ff7d6..9221e1d 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -42,6 +42,9 @@ static void __init imx6sx_init_irq(void)
>  static void __init imx6sx_init_late(void)
>  {
>         imx6q_cpuidle_init();
> +
> +       if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
> +               platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
