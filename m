From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 12 Jun 2016 13:22:23 +0200
Subject: [linux-sunxi] [PATCH 0/5] net-next: ethernet: add sun8i-emac
 driver
In-Reply-To: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <c8037d93-1d12-fdfb-a88b-e88ff0f72d52@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-06-16 11:56, LABBE Corentin wrote:
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

Awesome! Thanks for your work on this.

I've tested this on a orangepi-one. You can add my:

Tested-by: Hans de Goede <hdegoede@redhat.com>

For the next version of this series.

Attached is a dts patch for adding support
for the emac one that one (to be applied on top of this patch-set).

I've a Orange PI Plus and a Orange PI 2 as well, both of which use an external
phy, I would love to test on those as well, do you've a tree with adds the
necessary regulator bits and an example of how this would like in dts
somewhere ?

One remark about:
[PATCH 5/5] ARM: dts: sun8i: Enable sun8i-emac on the Orange PI PC

We always keep the nodes in board.dts files sorted alphebetically,
so the emac node should be after the ehci node rather then at the end.

Regards,

Hans

>
> Regards
>
> LABBE Corentin (5):
>   ethernet: add sun8i-emac driver
>   MAINTAINERS: Add myself as maintainers of sun8i-emac
>   ARM: sun8i: dt: Add DT bindings documentation for Allwinner sun8i-emac
>   ARM: dts: sun8i-h3: add sun8i-emac ethernet driver
>   ARM: dts: sun8i: Enable sun8i-emac on the Orange PI PC
>
>  .../bindings/net/allwinner,sun8i-emac.txt          |   64 +
>  MAINTAINERS                                        |    6 +
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   11 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |   14 +
>  drivers/net/ethernet/allwinner/Kconfig             |   13 +
>  drivers/net/ethernet/allwinner/Makefile            |    1 +
>  drivers/net/ethernet/allwinner/sun8i-emac.c        | 1943 ++++++++++++++++++++
>  7 files changed, 2052 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/allwinner,sun8i-emac.txt
>  create mode 100644 drivers/net/ethernet/allwinner/sun8i-emac.c
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-sun8i-Enable-sun8i-emac-on-the-Orange-PI-One.patch
Type: text/x-patch
Size: 1061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160612/44eec570/attachment-0001.bin>
