From: s.riedmueller@phytec.de (=?UTF-8?Q?Stefan_Riedm=c3=bcller?=)
Date: Mon, 22 Jan 2018 11:28:29 +0100
Subject: [PATCH v5 0/6] ARM: dts: Add PHYTEC phyCORE-i.MX 6 and
 phyBOARD-Mira carrier board support
In-Reply-To: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
References: <1515514200-9801-1-git-send-email-s.riedmueller@phytec.de>
Message-ID: <ce717f94-d175-a99b-ca27-afd9b50e162a@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I noticed this patch stack did not find its way into your next branch 
yet. Is there anything I can do to speed up the process?

Thanks,
Stefan

On 09.01.2018 17:09, Stefan Riedmueller wrote:
> This patchset adds support for the PHYTEC phyCORE-i.MX 6 and phyBOARD-Mira.
>
> Following boards are included:
> phyBOARD-Mira with phyCORE-i.MX 6 Quad/Dual with:
> - i.MX 6Quad/Dual SOC
> - NAND or eMMC
> - HDMI interface
> - LVDS display interface
> - Gigabit Ethernet
> - USB Host
> - CAN
> - RS232
> - PCIe
> This board also contains an LVDS camera interface and parallel display
> interface which are not yet supported.
>
> phyBAORD-Mira with phyCORE-i.MX 6 DualLight/Solo with:
> - i.MX 6DualLight/Solo
> - NAND
> - HDMI interface
> - 100 MBit/s Ethernet
> - USB Host
> - RS232
>
> phyBOARD-Mira with phyCORE-i.MX 6 QuadPlus with:
> - i.MX 6QuadPlus SOC
> - NAND
> - HDMI interface
> - LVDS display interface
> - Gigabit Ethernet
> - USB Host
> - CAN
> - RS232
> - PCIe
> This board also contains an LVDS camera interface and parallel display
> interface which are not yet supported.
>
> The entire series is based on v4.15-rc4.
>
> Changes since v1:
> - Removed unnecessary ipu aliases
> - Added unit-address to memory node name
> - Fixed eeprom compatible to correct vendor name (atmel instead of cat)
> - Fixed rtc compatible to correct vendor name (microcrystal instead of mc)
> - Changed pcie regulator to be used with vpcie-supply in &pcie node and
>    removed regulator-always-on
> - Changed pcie reset-gpio polarity to GPIO_ACTIVE_LOW
> - Replaced fsl,uart-has-rtscts by uart-has-rtscts
> - Fixed typos in defconfig patch
>
> Changes since v2:
> - Fixed typo in patch subject PATCH 4/6
> - Added reviewed by tags on PATCH 4/6 and PATCH 6/6
>
> Changes since v3:
> - Removed model and compatible from phycore dtsi
> - Changed flash compatible to jedec,spi-nor
> - Renamed some_green node to som-led-green
> - Dropped labels for eeprom, pmic, da9062_wdt and da9062_reg
> - Renamed flash label to m25p80
> - Put compatible at beginning of property lists
> - Changed copyright year to 2018
> - Added reviewed by tags on PATCH 1/6, 2/6, 3/6 and 5/6
>
> Changes since v4:
> - Rearranged &m25p80 node in dts files to fit alphabetical order
> - Fixed a parenthesis for uniformity in mira dtsi
>
> Christian Hemp (2):
>    ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6Quad/Dual RDK
>    ARM: dts: imx6: Add support for phyBOARD-Mira i.MX 6 DualLight/Solo
>      RDK
>
> Enrico Scholz (1):
>    ARM: dts: imx6: Add support for phyBOARD-Mira with i.MX 6QuadPlus
>
> Stefan Riedmueller (3):
>    ARM: dts: imx6: Add initial support for phyCORE-i.MX 6 SOM
>    ARM: dts: imx6: Add initial support for phyBOARD-Mira
>    ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor DA9062 driver
>
>   arch/arm/boot/dts/Makefile                        |   4 +
>   arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts |  64 ++++
>   arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts  |  72 ++++
>   arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts  |  72 ++++
>   arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi        | 390 ++++++++++++++++++++++
>   arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 279 ++++++++++++++++
>   arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts |  72 ++++
>   arch/arm/configs/imx_v6_v7_defconfig              |   4 +
>   8 files changed, 957 insertions(+)
>   create mode 100644 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
>   create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
>   create mode 100644 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
>   create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
>   create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
>   create mode 100644 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
>
