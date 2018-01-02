From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jan 2018 12:37:32 -0200
Subject: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
In-Reply-To: <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5Do-tyR0ruqfSeJm2FDP7_chNeroFStTF85GnSt_2g5Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Tue, Jan 2, 2018 at 3:07 PM, Anson Huang <Anson.Huang@nxp.com> wrote:

> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index d9b2c2d..cbda0cc 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -120,6 +120,10 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>                         clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
>                 clk_set_parent(step_clk, secondary_sel_clk);
>                 clk_set_parent(pll1_sw_clk, step_clk);
> +               if (freq_hz > clk_get_rate(pll2_bus_clk)) {
> +                       clk_set_rate(pll1_sys_clk, new_freq * 1000);
> +                       clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +               }

This change should be part of a different patch.

Thanks
