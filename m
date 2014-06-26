From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Jun 2014 22:23:01 -0300
Subject: [PATCH V2] ARM: imx: add cpufreq support for i.mx6sx
In-Reply-To: <1403687412-22362-1-git-send-email-b20788@freescale.com>
References: <1403687412-22362-1-git-send-email-b20788@freescale.com>
Message-ID: <CAOMZO5BDirj-5E0ha1iDzNSC1-+Exwo1QbZiP-7viDSpBqtEtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, Jun 25, 2014 at 6:10 AM, Anson Huang <b20788@freescale.com> wrote:
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

With this patch applied I get a flood of these messages:

cpu cpu0: failed to scale vddpu up: -22
cpufreq: __target_index: Failed to change cpu frequency: -22
cpu cpu0: failed to scale vddpu up: -22
cpufreq: __target_index: Failed to change cpu frequency: -22
cpu cpu0: failed to scale vddpu up: -22
cpufreq: __target_index: Failed to change cpu frequency: -22

Any suggestions?
