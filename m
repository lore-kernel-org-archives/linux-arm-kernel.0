From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Apr 2016 20:23:35 +0200
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <5167289.0a4LBoWhyX@wuerfel>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <20160426121335.GC11668@lunn.ch> <571FA3F6.7000903@gmail.com>
 <5167289.0a4LBoWhyX@wuerfel>
Message-ID: <20160426182335.GE30107@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> A more complex problem would be having a PHY driver for a device
> that can be either an ethernet phy or some other phy.

I doubt that ever happens. You can have up to 32 different devices on
an MDIO bus. Since an Ethernet PHY and a "some other sort of PHY" are
completely different things, why would a hardware engineer place them
on the same address? It is like saying your ATA controller and VGA
controller share the same slot on the PCI bus...

   Andrew
