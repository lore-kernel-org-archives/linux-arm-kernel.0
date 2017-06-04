From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Jun 2017 20:49:37 +0200
Subject: [PATCH] ARM: dts: imx: Fix Ethernet PHY reset polarity
In-Reply-To: <1496597475-1361-1-git-send-email-festevam@gmail.com>
References: <1496597475-1361-1-git-send-email-festevam@gmail.com>
Message-ID: <20170604184937.GA10273@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 02:31:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The FEC driver ignores the GPIO polarity from 'phy-reset-gpios' and
> considers that the Ethernet PHY is active low, unless the
> property 'phy-reset-active-high' is present.
> 
> Fix the device tree description by explicitly passing the 
> 'GPIO_ACTIVE_LOW' flag to the 'phy-reset-gpios' property.

Hi Fabio

Device tree bindings are supposed to be stable. So we can never fix
the FEC to respect the flag. This change to 'GPIO_ACTIVE_LOW' makes
the suggestion the flag is used, and can be set to GPIO_ACTIVE_HIGH.
If i were to change the value, i would set it to 42, or something new
like GPIO_FLAGS_BROKEN.

     Andrew
