From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Dec 2014 12:36:14 -0200
Subject: [PATCH 4/5] cpufreq: imx6q: add ldo-bypass support
In-Reply-To: <1414729631-11005-5-git-send-email-tharvey@gateworks.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
 <1414729631-11005-5-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5DzEe91pTv+UkCbj0DzgVDOb9hjuakt9NmpTJnEk-j8UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Fri, Oct 31, 2014 at 2:27 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> When an external PMIC is used for VDD_SOC and VDD_ARM you can save power by
> bypassing the internal LDO's provided by the anantop regulator as long as
> you are running less than 1.2GHz. If running at 1.2GHz the IMX6 datasheets
> state that you must use the internal LDO's to reduce ripple on the suplies.
>
> A failure to bypass the LDO's when using an external PMIC will result in an
> extra voltage drop (~125mV) between VDD_ARM_IN and VDD_ARM and VDD_SOC_IN and
> VDD_SOC which violates the voltages specificed by the datasheets.
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 51 +++++++++++++++++++++++++++++++++++++++++

Shouldn't the LDO bypass support be added into the anatop regulator
driver instead?

What if someone wants to use LDO bypass and not use the cpufreq driver?
