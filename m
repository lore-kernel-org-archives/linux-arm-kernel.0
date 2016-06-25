From: megous@megous.com (megous at megous.com)
Date: Sat, 25 Jun 2016 05:44:57 +0200
Subject: [PATCH v2] Thermal regulation for Orange Pi PC and Orange Pi One
Message-ID: <20160625034511.7966-1-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements thermal regulation on Orange Pi PC
and Orange Pi One.

The patch series contains:
- Thermal sensor driver for Allwinner H3 SoC
- Regulator driver for sy8106a I2C connected regulator
- DTS setup for gpio regulator used on Orange Pi One  
- Operating points and thermal zone setup for both SBCs

This is the second version of the patch series with incorporated
changes from the review of the first series.

Changes in v2:

ths:
- removed incorrect use of SID driver in sun8i_ths
- read calibration data directly from iomem  
- better explanation for the thermal sensor driver
- dt documentation fixes
- dropped unncecessary macros and init code reorganization
- moved resource aquisition from init to probe function
- deassert reset after clock rate is set, not before
- enable irq after all other registers are configured

sy8106a:
- added dt-bindings for the regulator
- changed to use of_device_id for probing
- added initialization failure checks

dts:
- add missing pinctrl-names for gpio-regulator
- move clocks/clock-latency to sun8i-h3.dtsi  

regards,
  Ond?ej Jirman
