From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Apr 2017 16:10:12 +0200
Subject: [PATCH v2] arm: imx6: zii: Add i210 PCIe interface to the device
 tree
In-Reply-To: <1493023642.2891.2.camel@pengutronix.de>
References: <1492321507-7174-1-git-send-email-cphealy@gmail.com>
 <1493023642.2891.2.camel@pengutronix.de>
Message-ID: <20170424141012.GA12780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:47:22AM +0200, Lucas Stach wrote:
> Am Samstag, den 15.04.2017, 22:45 -0700 schrieb Chris Healy:
> > The board has an Intel i210 Ethernet controller on its PCIe bus. Add a
> > device tree node for this.
> 
> I wold prefer a better description on why we need this node, as PCIe is
> an enumerable bus. Do you need this node to attach a MAC address or
> something?

Hi Lucas

We need to attach an Ethernet switch, using the DSA binding. Please
take a look at Documentation/binding/net/dsa.txt. We need a phandle to
the i210 Ethernet MAC.

    Andrew
