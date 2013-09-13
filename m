From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Sep 2013 20:45:51 +0800
Subject: [PATCH v4 2/3] ARM: imx6q: Add PCIe bits to GPR syscon definition
In-Reply-To: <1379065222-7275-3-git-send-email-xobs@kosagi.com>
References: <1379065222-7275-1-git-send-email-xobs@kosagi.com>
 <1379065222-7275-3-git-send-email-xobs@kosagi.com>
Message-ID: <20130913124549.GD31147@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 09:40:21AM +0000, Sean Cross wrote:
> PCIe requires additional bits be defined for GPR8 and GPR12.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index b6bdcd6..1bf1fe9 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -241,6 +241,12 @@
>  
>  #define IMX6Q_GPR5_L2_CLK_STOP			BIT(8)
>  
> +#define IMX6Q_GPR8_TX_DEEMPH_GEN1		(0x3F << 0)
> +#define IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB		(0x3F << 6)
> +#define IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB		(0x3F << 12)
> +#define IMX6Q_GPR8_TX_SWING_FULL		(0x7F << 18)
> +#define IMX6Q_GPR8_TX_SWING_LOW			(0x7F << 25)
> +

Can you please follow the existing pattern to define the bits from the
MSB to LSB, and use lowercase for hex values?

Shawn

>  #define IMX6Q_GPR9_TZASC2_BYP			BIT(1)
>  #define IMX6Q_GPR9_TZASC1_BYP			BIT(0)
>  
> @@ -273,7 +279,9 @@
>  #define IMX6Q_GPR12_ARMP_AHB_CLK_EN		BIT(26)
>  #define IMX6Q_GPR12_ARMP_ATB_CLK_EN		BIT(25)
>  #define IMX6Q_GPR12_ARMP_APB_CLK_EN		BIT(24)
> +#define IMX6Q_GPR12_DEVICE_TYPE			(0xF << 12)
>  #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
> +#define IMX6Q_GPR12_LOS_LEVEL			(0x1F << 4)
>  
>  #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
>  #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
> -- 
> 1.7.9.5
> 
