From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Jun 2013 10:51:09 +0200
Subject: [PATCH 0/4] Add an hwmon driver for the mxs soc internal sensor
Message-ID: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is ading a simple driver for the i.mx28 internal die temperature
sensor.

The first two patches are preparation patches an can be applied now.

The first patch is adding the #io-channel-cells to the lrdac on i.mx28 so that
it becomes an inkernel iio provider.

The second patch defines the lradc as present on the cfa-10036 and thus removes
it from i.mx28-cfa10049.dts and imx28-cfa10055.dts as they both include
imx28-cfa10036.dts

The third patch adds the driver itself.

And the final patch adds the driver bindings to the cfa-10036.

Alexandre Belloni (4):
  arm: mxs: Add #io-channel-cells property to lradc
  arm: mxs: add lradc to cfa10036
  hwmon: Add a simple driver to read the MXS SoC temperature
  arm: mxs: Add mxs internal temp sensor to cfa-10036

 .../devicetree/bindings/hwmon/mxs-cputemp.txt      |  18 +++
 Documentation/hwmon/mxs-cputemp                    |  29 +++++
 arch/arm/boot/dts/imx28-cfa10036.dts               |  10 ++
 arch/arm/boot/dts/imx28-cfa10049.dts               |   1 -
 arch/arm/boot/dts/imx28-cfa10055.dts               |   1 -
 arch/arm/boot/dts/imx28.dtsi                       |   1 +
 drivers/hwmon/Kconfig                              |  10 ++
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/mxs-cputemp.c                        | 132 +++++++++++++++++++++
 9 files changed, 201 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/mxs-cputemp.txt
 create mode 100644 Documentation/hwmon/mxs-cputemp
 create mode 100644 drivers/hwmon/mxs-cputemp.c

-- 
1.8.1.2
