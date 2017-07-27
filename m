From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 27 Jul 2017 15:48:34 +0200
Subject: [PATCH v2 05/11] net: stmmac: dwmac-rk: Add internal phy support
In-Reply-To: <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160540-30662-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170727134834.GD18666@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 09:02:16PM +0800, David Wu wrote:
> To make internal phy work, need to configure the phy_clock,
> phy cru_reset and related registers.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
> changes in v2:
>  - Use the standard "phy-mode" property for internal phy. (Florian)

I think we need to discuss this. This PHY appears to be on an MDIO
bus, it uses a standard PHY driver, and it appears to be using an RMII
interface. So it is just an ordinary PHY.

Internal is supposed to be something which is not ordinary, does not
use one of the standard phy modes, needs something special to make it
work.

Florain, it appears to be your suggestion to use internal. What do you
say?

	Andrew
