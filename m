From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jul 2018 22:35:56 +0200
Subject: [PATCH net-next 5/5 v2] net: gemini: Indicate that we can handle
 jumboframes
In-Reply-To: <20180704183324.10605-5-linus.walleij@linaro.org>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
 <20180704183324.10605-5-linus.walleij@linaro.org>
Message-ID: <20180704203556.GC23469@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 08:33:24PM +0200, Linus Walleij wrote:
> The hardware supposedly handles frames up to 10236 bytes and
> implements .ndo_change_mtu() so accept 10236 minus the ethernet
> header for a VLAN tagged frame on the netdevices. Use
> ETH_MIN_MTU as minimum MTU.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Hi Linus

Did you try with an MTU of 68? Maybe the vendor picked 256 because of
a hardware limit?

Otherwise the change looks good.

	  Andrew
