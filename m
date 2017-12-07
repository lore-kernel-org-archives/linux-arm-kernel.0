From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 7 Dec 2017 16:49:43 +0100
Subject: [PATCH net-next v2 6/8] net: phy: meson-gxl: leave CONFIG_A6
 untouched
In-Reply-To: <20171207142715.32578-7-jbrunet@baylibre.com>
References: <20171207142715.32578-1-jbrunet@baylibre.com>
 <20171207142715.32578-7-jbrunet@baylibre.com>
Message-ID: <20171207154943.GI24750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 03:27:13PM +0100, Jerome Brunet wrote:
> The PHY performs just as well when left in its default configuration and
> it makes senses because this poke gets reset just after init.

The only thing which might speak against this, is some bootloader
which sets something other than the default, and here we put it back
to the value it should have. But if you say a reset will put it back
to the default value anyway, this seems save.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
