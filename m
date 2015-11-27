From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Nov 2015 21:31:07 +0100
Subject: [PATCH 1/3] dt-bindings: add Marvell core PLL and clock divider
 PMU documentation
In-Reply-To: <20151127202114.GA613@rob-hp-laptop>
References: <E1a24wj-0004iw-Rf@rmk-PC.arm.linux.org.uk>
 <20151127202114.GA613@rob-hp-laptop>
Message-ID: <20151127203107.GD32356@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +Marvell Dove has a 2GHz PLL, which feeds into a set of dividers to provide
> > +high speed clocks for a number of peripherals.  These dividers are part of
> > +the PMU, and thus this node should be a child of the PMU node.
> 
> It seems a bit strange to just be documenting these clocks. What about 
> the rest of the SOC clocks?

$ ls Documentation/devicetree/bindings/clock/mvebu*
Documentation/devicetree/bindings/clock/mvebu-core-clock.txt
Documentation/devicetree/bindings/clock/mvebu-corediv-clock.txt
Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt

Dove is a member of mvebu, and gets most of its clocks from these
drivers. But it has additional clocks which are not shared with other
members of mvebu.

      Andrew
