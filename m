From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 May 2015 22:50:43 +0200
Subject: [PATCH v3 0/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <1430663256-22714-1-git-send-email-andrew@ncrmnt.org>
References: <1430663256-22714-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <20150503205043.GA23342@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

> DNS-327L is a 2-bay NAS with the following specs:     
>      - 512MiB RAM
>      - 128MiB NAND Flash
>      - 1 GbE interface (Marvell PHY)

...

> /* Set RGMII voltage to 1.8v, according to public docs. Nice! */
> mw.l 0xd00184e0 0xa8a; 
> /* Some weird magic that goes into phy registers, no public docs */
> phyWrite 0 16 2; 
> phyWrite 0 19 77; 
> phyWrite 0 18 5747; 

Take a look at the marvell,reg-init property. Might do what you need.

     Andrew
