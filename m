From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 15:44:38 +0800
Subject: [PATCH 3/3] arm64: defconfig: Enable CONFIG_REGULATOR_AXP20X
In-Reply-To: <1502516443-4740-3-git-send-email-jteki@openedev.com>
References: <1502516443-4740-1-git-send-email-jteki@openedev.com>
 <1502516443-4740-3-git-send-email-jteki@openedev.com>
Message-ID: <CAGb2v65yakT6EtLZGRtczUvuz7fEHV2Edj71kBo9s-eVji1V+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 1:40 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
>
> X-POWERS AXP20X PMIC Regulators is need for sunxi a64
> so make it default in defconfig.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied with the following commit message:

arm64: defconfig: Enable REGULATOR_AXP20X

The Allwinner A64 SoC is paired with the X-Powers AXP803 PMIC over the
Reduced Serial Bus (RSB). The regulators of this PMIC supply all power
rails of the SoC and many external peripherals.

Enable the driver for the regulators of this PMIC.

ChenYu

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a11fce7..d8f23c5 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -323,6 +323,7 @@ CONFIG_MFD_MAX77620=y
>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_MFD_RK808=y
>  CONFIG_MFD_SEC_CORE=y
> +CONFIG_REGULATOR_AXP20X=y
>  CONFIG_REGULATOR_FAN53555=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_GPIO=y
> --
> 2.7.4
>
