From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 5 Nov 2017 16:22:27 +0100
Subject: [PATCH net-next 4/8] net: ethernet: add the Alpine Ethernet driver
In-Reply-To: <1509884946.21689.10.camel@amazon.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-5-antoine.tenart@free-electrons.com>
 <20170203205823.GA22572@lunn.ch> <1503841641816.62526@amazon.com>
 <20170828180932.GG10418@lunn.ch>
 <8023db8c8218450fb6c97049db054989@EX13D13UWA001.ant.amazon.com>
 <723d35ce-aaa2-9011-19d6-99e77eed846f@gmail.com>
 <1509884946.21689.10.camel@amazon.com>
Message-ID: <20171105152227.GY24320@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> the problem is that physical MDIO controller actually belongs to one of
> the pcie devices and it's not independent interface, as the registers
> address belongs to that pcie device, also, a reset to that pcie device
> will reset the "shared" mdio controller.

What is the implications of resetting the mdio controller?

It still seems like you should only register one MDIO device with
linux, and then use phy-handle properties to point to the PHYs on the
bus.

       Andrew
