From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 11 Aug 2014 15:21:34 +0200
Subject: [PATCH v2 0/6] mvebu: Network devicetree pin muxing
In-Reply-To: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140811132134.GI26751@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 09:14:35AM -0300, Ezequiel Garcia wrote:
> This series adds the proper devicetree pin muxing for the network interfaces
> on all Armada 370 boards.
> 
> The MDIO interface uses pins MPP17 and MPP18, and so this is needed
> on all devices using MDIO.
> 
> For the ethernet interfaces, only the boards connecting with RGMII/GMII/MII
> need the mux. On this SoC, the SGMII is available on dedicated SerDes lanes,
> and so no MPP pin mux is required.
> 
> Given all the supported board use either RGMII or SGMII, we only add RGMII mux
> configuration. The only board which uses SGMII is the Armada 370 Reference
> Design board.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> 
> Patches have been tested on Armada 370 Mirabox only, using the recently submitted
> mvneta support for barebox. The series is based on v3.16.
> 
> It would be great if someone else can test on the other boards, to make sure
> no regressions are introduced.
> 
> Changes from v1:
> 
>   * Replaced mux node name: ge{0,1}_pins -> ge{0,1}_rgmii_pins to be clear
>     about the MII.
> 
>   * Replaced {}_pins -> {}-pins, to be consistent.
> 
>   * Massaged the commit logs a bit.
> 
> Ezequiel Garcia (6):
>   ARM: mvebu: Add network pin mux configuration for the Armada 370 SoC
>   ARM: mvebu: Add proper pin muxing on Globalscale Mirabox board
>   ARM: mvebu: Add proper pin muxing on the Armada 370 DB board
>   ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 102
>   ARM: mvebu: Add proper pin muxing on Netgear ReadyNAS 104
>   ARM: mvebu: Add proper pin muxing on Armada 370 RD board
> 
>  arch/arm/boot/dts/armada-370-db.dts            |  6 ++++++
>  arch/arm/boot/dts/armada-370-mirabox.dts       |  6 ++++++
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts |  4 ++++
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts |  6 ++++++
>  arch/arm/boot/dts/armada-370-rd.dts            |  4 ++++
>  arch/arm/boot/dts/armada-370.dtsi              | 19 +++++++++++++++++++
>  6 files changed, 45 insertions(+)
> 
> -- 
> 2.0.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
