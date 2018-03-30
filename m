From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 30 Mar 2018 16:03:20 +0800
Subject: [linux-sunxi] [PATCH v2 02/10] regulator: add support for SY8106A
 regulator
In-Reply-To: <20180206044905.30508-3-icenowy@aosc.io>
References: <20180206044905.30508-1-icenowy@aosc.io>
 <20180206044905.30508-3-icenowy@aosc.io>
Message-ID: <CAGb2v64_FhwZQCNeCa1G6bGM_mszc2BmECP+z4rKjrLB2+awmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 6, 2018 at 12:48 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> SY8106A is an I2C attached single output regulator made by Silergy Corp,
> which is used on several Allwinner H3/H5 SBCs to control the power
> supply of the ARM cores.
>
> Add a driver for it.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Change commit message, remove enable/disable code, add default
>  ramp_delay, add comment for go bit]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped the enable/disable code.
> - Added default ramp_delay value.
> - Added comment for the "go bit".
>
>  drivers/regulator/Kconfig             |   8 +-
>  drivers/regulator/Makefile            |   2 +-
>  drivers/regulator/sy8106a-regulator.c | 168 ++++++++++++++++++++++++++++++++++
>  3 files changed, 176 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/regulator/sy8106a-regulator.c
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index b27417ca188a..70227230bca2 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -792,6 +792,13 @@ config REGULATOR_STW481X_VMMC
>           This driver supports the internal VMMC regulator in the STw481x
>           PMIC chips.
>
> +config REGULATOR_SY8106A
> +       tristate "Silergy SY8106A regulator"
> +       depends on I2C && (OF || COMPILE_TEST)
> +       select REGMAP_I2C
> +       help
> +         This driver supports SY8106A single output regulator.
> +
>  config REGULATOR_TPS51632
>         tristate "TI TPS51632 Power Regulator"
>         depends on I2C
> @@ -966,4 +973,3 @@ config REGULATOR_WM8994
>           WM8994 CODEC.
>
>  endif
> -
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 19fea09ba10a..7564664c64df 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_REGULATOR_SC2731) += sc2731-regulator.o
>  obj-$(CONFIG_REGULATOR_SKY81452) += sky81452-regulator.o
>  obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
> +obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>  obj-$(CONFIG_REGULATOR_TI_ABB) += ti-abb-regulator.o
>  obj-$(CONFIG_REGULATOR_TPS6105X) += tps6105x-regulator.o
>  obj-$(CONFIG_REGULATOR_TPS62360) += tps62360-regulator.o
> @@ -124,5 +125,4 @@ obj-$(CONFIG_REGULATOR_WM8350) += wm8350-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8400) += wm8400-regulator.o
>  obj-$(CONFIG_REGULATOR_WM8994) += wm8994-regulator.o
>
> -

Extra whitespace change. Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>  ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG
