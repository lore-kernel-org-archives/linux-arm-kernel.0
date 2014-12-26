From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 26 Dec 2014 13:34:51 +0100
Subject: [PATCH 0/3] OMAP3 temperature sensor
In-Reply-To: <20141226102933.GA28778@amd>
References: <20141226102933.GA28778@amd>
Message-ID: <1419597294-21487-1-git-send-email-sre@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've prepared an updated variant of the omap34xx temperature monitor driver.
It's based on the N9 driver instead of the N900 driver (and thus has omap36xx
support).

The differences compared to the original driver are:

 * DT based
 * No includes from arch, instead uses syscon DT node + regmap
 * Removed support for raw temperature reading
  - I assume this was used for debugging and regmap can be used
    instead with newer kernels.
 * Introduction of managed resources where possible
 * Usage of module_platform_driver() macro
 * Added some comments referencing the TRM

So far the patchset is _compile-tested only_. I will test it on my N900 in
the next days.

-- Sebastian

Sebastian Reichel (3):
  DT Binding for omap3 temperature sensor
  hwmon: Driver for OMAP3 temperature sensor
  ARM: dts: OMAP34xx/36xx: Add temperature sensor

 .../bindings/hwmon/omap3-temperature.txt           |  25 ++
 arch/arm/boot/dts/omap34xx.dtsi                    |   7 +
 arch/arm/boot/dts/omap36xx.dtsi                    |   7 +
 drivers/hwmon/Kconfig                              |   8 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/omap3-temp.c                         | 307 +++++++++++++++++++++
 6 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/omap3-temperature.txt
 create mode 100644 drivers/hwmon/omap3-temp.c

-- 
2.1.3
