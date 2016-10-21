From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Oct 2016 17:46:34 +0200
Subject: [RFC PATCH 08/13] dwmac-meson8b: add support for phy selection
In-Reply-To: <1477060838-14164-9-git-send-email-narmstrong@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
 <1477060838-14164-9-git-send-email-narmstrong@baylibre.com>
Message-ID: <20161021154634.GQ16974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 04:40:33PM +0200, Neil Armstrong wrote:
> The Meson GXL dwmac Glue Layer also provides switching between an external PHY
> and an internal RMII 10/100 PHY.
> Add a way to setup the correct PHY switching from a device tree attribute.

Hi Neil

Can this be made automatic?

The internal PHY appears to be on address 8. Can there also be an
external PHY on address 8? Could you follow the phy-handle link to the
phy node, check the address, and if it is 8, configure for an internal
PHY?

	Andrew
