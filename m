From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 02 Aug 2018 13:58:51 +0200
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add core dtsi file for PX30
 SoCs
In-Reply-To: <1533113116-8820-4-git-send-email-cl@rock-chips.com>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
 <1533113116-8820-4-git-send-email-cl@rock-chips.com>
Message-ID: <5420010.G1GNdo6K2G@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 1. August 2018, 10:45:15 CEST schrieb cl at rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds core dtsi file for Rockchip PX30 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied with the following changes:
- some reordering
- cpu properties should be present in all cpu nodes (clocks etc)
- added dma-names to uarts
- dropped #dma-cells from uarts+spi (only for dma-controllers)
- dropped phy-names from usb nodes without actual phys
  (please readd once you have phy support)
- dropped the gamma_lut + reg-names and spanned the
  registers till below the iommu, similar to all other socs we have
- dropped the high_speed pinctrl state from the spi nodes
  (not part of mainline dt-binding)
- dropped peripherals-req-type-burst from the dmac
  (not part of mainline dt-binding)
- split out dwc2 into separate patch to be applied once the binding lands
- set #sound-dai-cells in px30.dtsi ... property of the i2s controller
  and doesn't change per board


Heiko
