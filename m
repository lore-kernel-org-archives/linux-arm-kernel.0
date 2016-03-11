From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 11 Mar 2016 18:31:25 +0100
Subject: [PATCH 1/3] net: thunderx: Cleanup PHY probing code.
In-Reply-To: <1457714822-5754-2-git-send-email-ddaney.cavm@gmail.com>
References: <1457714822-5754-1-git-send-email-ddaney.cavm@gmail.com>
 <1457714822-5754-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160311173125.GI3153@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		phy_np = of_parse_phandle(node, "phy-handle", 0);
> +		/* If there is no phy or defective firmware presents
> +		 * this cortina phy, for which there is no driver
> +		 * support, ignore it.
> +		 */
> +		if (phy_np &&
> +		    !of_device_is_compatible(phy_np, "cortina,cs4223-slice")) {

Hi David

What is a cortina,cs4223-slice, and why does it need to be handled differently?

Thanks
	Andrew
