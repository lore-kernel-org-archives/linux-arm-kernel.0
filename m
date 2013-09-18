From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Wed, 18 Sep 2013 12:01:19 +0200
Subject: [PATCH 0/4] Add I2C support to ST SoCs
Message-ID: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to add I2C support to ST SoCs.
The DT definition is added for STiH415 and STiH416 SoCs on
B2000 and B2020 boards.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Maxime Coquelin (4):
  i2c: busses: i2c-st: Add ST I2C controller
  ARM: STi: Supply I2C configuration to STiH416 SoC
  ARM: STi: Supply I2C configuration to STiH415 SoC
  ARM: STi: Add I2C config to B2000 and B2020 boards

 Documentation/devicetree/bindings/i2c/i2c-st.txt |   35 ++
 arch/arm/boot/dts/stih415-pinctrl.dtsi           |   36 ++
 arch/arm/boot/dts/stih415.dtsi                   |   57 ++
 arch/arm/boot/dts/stih416-pinctrl.dtsi           |   35 ++
 arch/arm/boot/dts/stih416.dtsi                   |   57 ++
 arch/arm/boot/dts/stih41x-b2000.dtsi             |    7 +
 arch/arm/boot/dts/stih41x-b2020.dtsi             |   20 +
 drivers/i2c/busses/Kconfig                       |   10 +
 drivers/i2c/busses/Makefile                      |    1 +
 drivers/i2c/busses/i2c-st.c                      |  713 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-st.h                      |  216 +++++++
 11 files changed, 1187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
 create mode 100644 drivers/i2c/busses/i2c-st.c
 create mode 100644 drivers/i2c/busses/i2c-st.h

-- 
1.7.9.5
