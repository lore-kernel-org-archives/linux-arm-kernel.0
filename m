From: davem@davemloft.net (David Miller)
Date: Sun, 27 Nov 2016 20:33:24 -0500 (EST)
Subject: [PATCH v2 0/7] stmmac: dwmac-meson8b: configurable RGMII TX delay
In-Reply-To: <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161127.203324.1634866862730391239.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 25 Nov 2016 14:01:49 +0100

> Currently the dwmac-meson8b stmmac glue driver uses a hardcoded 1/4
> cycle TX clock delay. This seems to work fine for many boards (for
> example Odroid-C2 or Amlogic's reference boards) but there are some
> others where TX traffic is simply broken.
> There are probably multiple reasons why it's working on some boards
> while it's broken on others:
> - some of Amlogic's reference boards are using a Micrel PHY
> - hardware circuit design
> - maybe more...

The ARM arch file changes do not apply cleanly to net-next, you probably
want to merge them via the ARM tree instead of mine, and respin this series
to be without the .dts file changes.
