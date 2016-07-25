From: paulo@inutilfutil.com (paulo at inutilfutil.com)
Date: Mon, 25 Jul 2016 06:16:45 -0700 (PDT)
Subject: [PATCH v2 0/5] net-next: ethernet: add sun8i-emac driver
In-Reply-To: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <668e8915-109e-431e-96d0-908b1c6553ad@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 20, 2016 at 5:03:41 AM UTC-3, clabbe.montjoie wrote:
> Hello
> 
> This patch series add the driver for sun8i-emac which handle the Ethernet MAC
> present on Allwinner H3/A83T/A64 SoCs.
> 
> It supports 10/100/1000 Mbit/s speed with half/full duplex.
> It can use an internal PHY (MII 10/100) or an external PHY
> via RGMII/RMII.
> 
> This patch series enable the driver only for the H3 SoC since A83T and A64
> doesn't have the necessary clocks present in mainline.
> 
> This patch series enable the driver only for the OrangePiPC board since other
> board with H3 use external PHY which need optional regulators that will be
> supported later.
> 
> The driver have been tested on the following boards:
> - H3 Orange PI PC, Orange PI Plus, BananaPI-M2+
> - A64 Pine64
> - A83T BananaPI-M3
> 
> I would like to thanks Chen-Yu Tsai for his help on developing this driver.
> 
> Regards
> 
> Changes since v1
> - Implement NAPI
> - Sorted and reworded all define
> - Reworked ethtools stats strings
> - Removed all unneeded __packked and __aligned
> - Added tuning of RX/TX ring size via ethtool
> - Corrected use of sk/skb naming
> - Added some wmb when needed
> - Moved irq claim/free to emac_open/close
> - Lots of code refactoring
> 
> LABBE Corentin (5):
>   ethernet: add sun8i-emac driver
>   MAINTAINERS: Add myself as maintainers of sun8i-emac
>   ARM: sun8i: dt: Add DT bindings documentation for Allwinner sun8i-emac
>   ARM: dts: sun8i-h3: add sun8i-emac ethernet driver
>   ARM: dts: sun8i: Enable sun8i-emac on the Orange PI PC
> 
>  .../bindings/net/allwinner,sun8i-emac.txt          |   65 +
>  MAINTAINERS                                        |    6 +
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   11 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |   14 +
>  drivers/net/ethernet/allwinner/Kconfig             |   13 +
>  drivers/net/ethernet/allwinner/Makefile            |    1 +
>  drivers/net/ethernet/allwinner/sun8i-emac.c        | 2127 ++++++++++++++++++++
>  7 files changed, 2237 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>  create mode 100644 drivers/net/ethernet/allwinner/sun8i-emac.c
> 
> -- 
> 2.7.3

Works on my Orange Pi PC. Thank you!

IMHO, we should enable this module on sunxi_defconfig.

Paulo
