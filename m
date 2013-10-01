From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Tue,  1 Oct 2013 12:39:08 +0200
Subject: [PATCH v3 0/4] Add I2C support to ST SoCs
Message-ID: <1380623952-4252-1-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to add I2C support to ST SoCs.
The DT definition is added for STiH415 and STiH416 SoCs on
B2000 and B2020 boards.

The series has been tested working on STiH416-B2020 board.
It applies on top of v3.12-rc3.

Changes since v2:
  - Create generic DT property for Anti-glitch filtering configuration
  - Sort i2c-st entries in Makefile and Kconfig
  - Various cosmetics changes
  - Return IRQ_NONE in case of spurious interrupt
  - Use INIT_COMPLETION instead of init_completion in st_i2c_xfer_msg
  - Simplify st_i2c_xfer as proposed by Wolfram
  - Fix PM ops issues
  - Change author name to myself and fix license to GPL v2
  - Include .h file content into the .c file

Changes since v1:
  - Anti-glitch filtering simplified (Only HW Anti-glitch is kept)
  - Update I2C timings to comply with I2C specification
  - Handle spurious interrupts properly
  - DT binding updates taking into account Stephen's comments
  - Use "clock-names" property to comply with GCF
  - DT cosmetic changes reported by Lee and Gabriel 

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>

Maxime Coquelin (4):
  i2c: busses: i2c-st: Add ST I2C controller
  ARM: STi: Supply I2C configuration to STiH416 SoC
  ARM: STi: Supply I2C configuration to STiH415 SoC
  ARM: STi: Add I2C config to B2000 and B2020 boards

 Documentation/devicetree/bindings/i2c/i2c-st.txt |   34 +
 arch/arm/boot/dts/stih415-pinctrl.dtsi           |   36 +
 arch/arm/boot/dts/stih415.dtsi                   |   53 ++
 arch/arm/boot/dts/stih416-pinctrl.dtsi           |   35 +
 arch/arm/boot/dts/stih416.dtsi                   |   53 ++
 arch/arm/boot/dts/stih41x-b2000.dtsi             |    9 +
 arch/arm/boot/dts/stih41x-b2020.dtsi             |   22 +
 drivers/i2c/busses/Kconfig                       |   10 +
 drivers/i2c/busses/Makefile                      |    1 +
 drivers/i2c/busses/i2c-st.c                      |  867 ++++++++++++++++++++++
 10 files changed, 1120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-st.txt
 create mode 100644 drivers/i2c/busses/i2c-st.c

-- 
1.7.9.5
