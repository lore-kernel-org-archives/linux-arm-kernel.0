From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Oct 2016 18:08:07 +0200
Subject: [RFC PATCH 08/13] dwmac-meson8b: add support for phy selection
In-Reply-To: <dc810494-6ece-c4ae-d412-ed9af3fac9c2@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
 <1477060838-14164-9-git-send-email-narmstrong@baylibre.com>
 <20161021155408.GR16974@lunn.ch>
 <dc810494-6ece-c4ae-d412-ed9af3fac9c2@baylibre.com>
Message-ID: <20161021160807.GT16974@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil

> Yes this would be a good idea if we were able to scan the internal
> and external PHYs at the same time, but with our limited knowledge
> the values we write in the register seems to switch a mux for the
> whole RMII and MDIO signals to either interface.

Ah, O.K. So you need something like:

drivers/net/phy/mdio-mux-mmioreg.c

This seems to be limited to a single byte for the mux register, so you
might need to make some extensions.

      Andrew
