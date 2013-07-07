From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  7 Jul 2013 18:31:55 -0300
Subject: [PATCH 0/4] A10S-OLinuXino-Micro I2C support
Message-ID: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds the required DT nodes to get I2C supported and 
working on the OLIMEX A10S-OLinuXino-Micro board.

Patch 1 adds the muxings as seen on the board's schematics. Patch 2 adds 
the DT nodes, based on other sunxi dts, as we don't have an A10S user 
manual so far. Patch 3 enables the controllers, and patch 4 adds a node 
for the AT24 EEPROM found on the board.

I have tested and can see the PMU on I2C-0 using i2cdetect, and can read 
the EEPROM contents on I2C-1. I have not tested I2C-2, but i2cdetect 
reports no devices so I suppose it's working okay too.

Any testing or review will be appreciated :)

Thanks,

Emilio

Emilio L?pez (4):
  ARM: sun5i: dt: Add I2C muxings for sun5i A10S
  ARM: sun5i: dt: Add I2C controller nodes to the A10S dtsi
  ARM: sun5i: dt: Enable I2C controllers on A10S-OLinuXino-Micro
  ARM: sun5i: dt: Add AT24 device on A10S-OLinuXino-Micro

 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 25 +++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 54 ++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

-- 
1.8.3.2
