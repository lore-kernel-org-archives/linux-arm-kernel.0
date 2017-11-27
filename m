From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Nov 2017 14:29:03 +0100
Subject: [PATCH] ARM: dts: imx53-cx9020: Fix the Ethernet PHY reset GPIO
 polarity
In-Reply-To: <1511650267-21933-1-git-send-email-festevam@gmail.com>
References: <1511650267-21933-1-git-send-email-festevam@gmail.com>
Message-ID: <20171127132903.GD19413@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 08:51:07PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As explained in Documentation/devicetree/bindings/net/fsl-fec.txt the
> phy-reset-gpios is active high only if the 'phy-reset-active-high' is
> present.
> 
> As 'phy-reset-active-high' is not used here, fix the device tree
> description by passing GPIO_ACTIVE_LOW flag.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio

Do you have a bigger plan than just 'documentation'. Given that device
tree is an ABI, the GPIO_ACTIVE_ flag has to be ignored. Having it
correct is just documentation.

If you want to fix them all, is it worth adding in a warning to detect
a miss match between the GPIO_ACTIVE_* and phy-reset-active-high?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
