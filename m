From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Dec 2016 11:25:28 +0000
Subject: [PATCH v4 00/12] mmc: Add support to Marvell Xenon SD Host
 Controller
In-Reply-To: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
References: <cover.67d726f70f6bd48d38a2023513f2711080bc66c8.1481651244.git-series.gregory.clement@free-electrons.com>
Message-ID: <20161222112528.GZ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 06:48:29PM +0100, Gregory CLEMENT wrote:
> This the forth version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).

With the problems and niggles fixed, it seems to work here on my 8040
board (along with dma-coherent):

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: SDHCI controller on f06e0000.sdhci [f06e0000.sdhci] using ADMA 64-bit
mmc0: new high speed MMC card at address 0001
mmcblk0: mmc0:0001 8GND3R 7.28 GiB
mmc1: SDHCI controller on f2780000.sdhci [f2780000.sdhci] using ADMA 64-bit
mmcblk0boot0: mmc0:0001 8GND3R partition 1 4.00 MiB
mmcblk0boot1: mmc0:0001 8GND3R partition 2 4.00 MiB
mmcblk0rpmb: mmc0:0001 8GND3R partition 3 512 KiB
mmc1: new high speed SDHC card at address 0001
mmcblk1: mmc1:0001 00000 14.6 GiB
 mmcblk1: p1 p2 p3

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
