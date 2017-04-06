From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 06 Apr 2017 10:30:46 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Add support for phyCORE-RK3288 SoM
In-Reply-To: <1491214985-18331-1-git-send-email-w.egorov@phytec.de>
References: <1491214985-18331-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1872284.4EEa8KbvLF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. April 2017, 12:23:03 CEST schrieb Wadim Egorov:
> The phyCORE-RK3288 is a SoM (System on Module) containing a RK3288 SoC.
> The module can be connected to different carrier boards.
> It can be also equipped with different RAM, SPI flash and eMMC variants.
> The Rapid Development Kit option is using the following setup:
> 
>   - 1 GB DDR3 RAM (2 Banks)
>   - 1x 4 KB EEPROM
>   - DP83867 Gigabit Ethernet PHY
>   - 16 MB SPI Flash
>   - 4 GB eMMC Flash
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

applied for 4.12 with the following minor changes:

- moved phy-handle property up a bit
- switches compatible and #address+#size-cells in mdio0
- dropped rockchip,grf from &io_domains (grf is a simple-mfd and can
  get the grf syscon on its own via its parent)
- vdd_cpu: regulator at 60 (from fan53555 at 60)
- serial_flash: flash at 0 (from m25p80 at 0)
  Nodes should be named after their "category" not the actual device

Thanks
Heiko
