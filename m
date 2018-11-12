From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Nov 2018 18:03:31 +0100
Subject: [RFC PATCH 2/6] phy: armada38x: add common phy support
In-Reply-To: <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
 <E1gMBMi-00089Q-7S@rmk-PC.armlinux.org.uk>
Message-ID: <20181112170331.GB5075@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int a38x_comphy_poll(struct a38x_comphy_lane *lane,
> +			    unsigned int offset, u32 mask, u32 value)
> +{
> +	unsigned int timeout = 10;
> +	u32 val;
> +
> +	while (1) {
> +		val = readl_relaxed(lane->base + offset);
> +		if ((val & mask) == value)
> +			return 0;
> +		if (!timeout--)
> +			break;
> +		udelay(10);
> +	}

Hi Russell

Maybe use one of the readx_poll_timeout() variants?

      Andrew
