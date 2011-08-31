From: hector.oron@gmail.com (Hector Oron)
Date: Wed, 31 Aug 2011 14:02:58 +0100
Subject: i.MX multi SoC patches
In-Reply-To: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
References: <1314172987-10349-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAODfWeFnsQZBsBXpJLVknzvqcythZjDMyfe8sb9Pdw_uK-iB2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> This is hopefully the last iteration of the patches for compiling
> all ARMv4/v5 based i.MXs together. CONFIG_ARM_PATCH_PHYS_VIRT
> lost its experimental status and we can still build uImages
> even with CONFIG_AUTO_ZRELADDR enabled. This series selects
> these options and makes a multi SoC image the default.
> Also, we can now build all i.MX5 SoCs into a single image.
> This series also updates the defconfigs.

On a mx53 loco board I have rebased Richard's patchset for SATA and
got it running, but I see this on mapping on iomem, board is more or
less working but I was unsure if this is something significant or just
some ugly cosmetic names for mx53 (i.e. imx21-uart.0, imx31-gpio, ..)

root at build-arm01:~# cat /proc/iomem
10000000-10000fff : imx53-ahci.0
50004000-50007fff : sdhci-esdhc-imx53.0
  50004000-50007fff : mmc0
50020000-50023fff : sdhci-esdhc-imx53.2
  50020000-50023fff : mmc1
53f84000-53f87fff : imx31-gpio.0
  53f84000-53f87fff : imx31-gpio
53f88000-53f8bfff : imx31-gpio.1
  53f88000-53f8bfff : imx31-gpio
53f8c000-53f8ffff : imx31-gpio.2
  53f8c000-53f8ffff : imx31-gpio
53f90000-53f93fff : imx31-gpio.3
  53f90000-53f93fff : imx31-gpio
53f98000-53f9bfff : imx2-wdt.0
  53f98000-53f9bfff : imx2-wdt.0
53fbc000-53fbcfff : imx21-uart.0
  53fbc000-53fbcfff : imx-uart
53fdc000-53fdffff : imx31-gpio.4
  53fdc000-53fdffff : imx31-gpio
53fe0000-53fe3fff : imx31-gpio.5
  53fe0000-53fe3fff : imx31-gpio
53fe4000-53fe7fff : imx31-gpio.6
  53fe4000-53fe7fff : imx31-gpio
63fb0000-63fb3fff : imx35-sdma
63fc4000-63fc4fff : imx-i2c.1
  63fc4000-63fc4fff : imx-i2c
63fc8000-63fc8fff : imx-i2c.0
  63fc8000-63fc8fff : imx-i2c
63fec000-63fecfff : imx25-fec.0
  63fec000-63fecfff : imx25-fec
70000000-8fffffff : System RAM
  70008000-70411fff : Kernel text
  70438000-704b137f : Kernel data



-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
