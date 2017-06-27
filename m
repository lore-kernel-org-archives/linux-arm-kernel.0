From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Jun 2017 16:52:16 +0200
Subject: [PATCH 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <1f8255c9-14c1-440f-0f0c-d173ed439d8d@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
 <1498193947-8011-1-git-send-email-david.wu@rock-chips.com>
 <3788bbae-c99c-b63e-8910-f98567124cac@gmail.com>
 <1f8255c9-14c1-440f-0f0c-d173ed439d8d@rock-chips.com>
Message-ID: <20170627145216.GE9921@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm a little confused for the property of phy-mode = "internal".
> If the property of phy-mode is configured as "internal" from DT , i
> could not get the rmii or rgmii mode for the phy.
> I use it to differentiate rmii or rgmii for different configuration.

phy-mode is about the bus between the MAC and the PHY. Internal means
there is not a standard bus between the MAC and the PHY, something
proprietary is being used to embed the PHY in the MAC.

If you are using RMII or RGMII, then it is not internal, in that as
standard bus is being used. It does not matter if that bus is not
available external to the SoC, it still exists.

	  Andrew
