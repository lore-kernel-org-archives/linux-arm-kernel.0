From: christophe.roullier@st.com (Christophe ROULLIER)
Date: Wed, 25 Apr 2018 07:12:29 +0000
Subject: [PATCH  1/8] net: ethernet: stmmac: add adaptation for
 stm32mp157c.
In-Reply-To: <20180424153953.GB2360@lunn.ch>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-2-git-send-email-christophe.roullier@st.com>
 <20180424153953.GB2360@lunn.ch>
Message-ID: <fa12bb221b1b4cf380812c0fed03f74d@SFHDAG5NODE3.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

For moment, I've only tested with PHY RGMII, RMII, MII, GMII, I do not have other kind of PHY interface.
Normally there is no impact in my glue, the value of syscfg register will be the same for RGMII/ID/TXID/RXID.
Do you think that I should add these interfaces in my case ?

	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
		val = SYSCFG_PMCR_ETH_SEL_RGMII;
		if (dwmac->int_phyclk)
			val |= SYSCFG_PMCR_ETH_CLK_SEL;
		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
		break;

Christophe.

-----Original Message-----
From: Andrew Lunn [mailto:andrew at lunn.ch] 
Sent: mardi 24 avril 2018 17:40
To: Christophe ROULLIER <christophe.roullier@st.com>
Cc: mark.rutland at arm.com; mcoquelin.stm32 at gmail.com; Alexandre TORGUE <alexandre.torgue@st.com>; Peppe CAVALLARO <peppe.cavallaro@st.com>; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org
Subject: Re: [PATCH 1/8] net: ethernet: stmmac: add adaptation for stm32mp157c.

On Tue, Apr 24, 2018 at 05:01:53PM +0200, Christophe Roullier wrote:

> +	case PHY_INTERFACE_MODE_RGMII:
> +		val = SYSCFG_PMCR_ETH_SEL_RGMII;
> +		if (dwmac->int_phyclk)
> +			val |= SYSCFG_PMCR_ETH_CLK_SEL;
> +		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
> +		break;

Hi Christophe

What about PHY_INTERFACE_MODE_RGMII_ID, PHY_INTERFACE_MODE_RGMII_RXID and PHY_INTERFACE_MODE_RGMII_TXID.

    Andrew
