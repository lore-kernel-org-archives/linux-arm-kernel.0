From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Jun 2014 00:53:50 +0400
Subject: [PATCH 2/4] phy: miphy365x: Add MiPHY365x header file for DT
 x Driver defines
In-Reply-To: <1400766819-22286-3-git-send-email-lee.jones@linaro.org>
References: <1400766819-22286-1-git-send-email-lee.jones@linaro.org>
 <1400766819-22286-3-git-send-email-lee.jones@linaro.org>
Message-ID: <53AB36DE.7090908@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/22/2014 05:53 PM, Lee Jones wrote:

> This provides the shared header file which will be reference from both
> the MiPHY365x driver and its associated Device Tree node(s).

> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   include/dt-bindings/phy/phy-miphy365x.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 include/dt-bindings/phy/phy-miphy365x.h

> diff --git a/include/dt-bindings/phy/phy-miphy365x.h b/include/dt-bindings/phy/phy-miphy365x.h
> new file mode 100644
> index 0000000..8757c02
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-miphy365x.h
> @@ -0,0 +1,25 @@
> +/*
> + * This header provides constants for the phy framework
> + * based on the STMicroelectronics miphy365x.
> + */
> +#ifndef _DT_BINDINGS_PHY_MIPHY
> +#define _DT_BINDINGS_PHY_MIPHY
> +
> +/* Supports 16 ports without a datatype change (u8 & 0xF0). */
> +#define MIPHY_PORT_0			0
> +#define MIPHY_PORT_1			1
> +#define MIPHY_PORT_2			2
> +#define MIPHY_PORT_3			3
> +
> +/* Supports 16 types without a datatype change (u8 & 0x0F). */
> +#define MIPHY_TYPE_SHIFT		4
> +#define MIPHY_TYPE_SATA			(0 << MIPHY_TYPE_SHIFT)
> +#define MIPHY_TYPE_PCIE			(1 << MIPHY_TYPE_SHIFT)
> +#define MIPHY_TYPE_USB			(2 << MIPHY_TYPE_SHIFT)
> +
> +#define MIPHY_SATA_PORT0		(MIPHY_TYPE_SATA) | (MIPHY_PORT_0)
> +#define MIPHY_SATA_PORT1		(MIPHY_TYPE_SATA) | (MIPHY_PORT_1)
> +#define MIPHY_PCIE_PORT0		(MIPHY_TYPE_PCIE) | (MIPHY_PORT_0)
> +#define MIPHY_PCIE_PORT1		(MIPHY_TYPE_PCIE) | (MIPHY_PORT_1)

    No need to have parens around macros but you should instead enclose the 
'|' operator and its arguments into parens.

WBR, Sergei
