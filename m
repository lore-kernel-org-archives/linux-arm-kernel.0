From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Apr 2016 19:45:05 +0200
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <571FA3F6.7000903@gmail.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
 <20160425205650.GA31129@lunn.ch>
 <666dffb41a922b0c8638f2f002a2de08@mail.gmail.com>
 <20160426121335.GC11668@lunn.ch> <571FA3F6.7000903@gmail.com>
Message-ID: <20160426174505.GD11668@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I am not clear on how common a shared MDIO bus is on other SoCs, but the
> other Broadcom SoCs I am familiar with have dedicated MDIO buses
> instances per type of PHY (PCIe, BUSB, Ethernet), thus making the split
> a ton easier.

I don't actually see this shared bus being an issue, once the mux it
implemented. With the mux, you see N MDIO busses, each acting like a
normal MDIO bus. I've used the GPIO variety and had no issues:

http://marc.info/?l=linux-arm-kernel&m=145910090401796&w=2

	Andrew
