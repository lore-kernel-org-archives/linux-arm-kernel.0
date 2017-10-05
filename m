From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 6 Oct 2017 00:21:59 +0200
Subject: [PATCH v6 11/11] of: mdio: Prevent of_mdiobus_register from
 scanning mdio-mux nodes
In-Reply-To: <20171005220927.7rabn3ftvow253xj@rob-hp-laptop>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-12-clabbe.montjoie@gmail.com>
 <20170927141213.GF13516@lunn.ch>
 <c8697b60-294f-7cc1-8425-aa5b837fcca0@gmail.com>
 <20171005220927.7rabn3ftvow253xj@rob-hp-laptop>
Message-ID: <20171005222159.GO13247@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Looking at this some more, why can't mdio-mux-mmio be used?

Hi Rob

That was my first thought. And then i dug into the details. The mux is
more than just a couple of bits in an address space. Clocks needs to
be enabled/disabled, and the MAC needs a reset, when the mux changes.
So the mux needs intimate knowledge of MAC.

   Andrew
