From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Apr 2018 17:39:53 +0200
Subject: [PATCH  1/8] net: ethernet: stmmac: add adaptation for
 stm32mp157c.
In-Reply-To: <1524582120-4451-2-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-2-git-send-email-christophe.roullier@st.com>
Message-ID: <20180424153953.GB2360@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 05:01:53PM +0200, Christophe Roullier wrote:

> +	case PHY_INTERFACE_MODE_RGMII:
> +		val = SYSCFG_PMCR_ETH_SEL_RGMII;
> +		if (dwmac->int_phyclk)
> +			val |= SYSCFG_PMCR_ETH_CLK_SEL;
> +		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
> +		break;

Hi Christophe

What about PHY_INTERFACE_MODE_RGMII_ID, PHY_INTERFACE_MODE_RGMII_RXID
and PHY_INTERFACE_MODE_RGMII_TXID.

    Andrew
