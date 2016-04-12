From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Apr 2016 14:57:24 +0100
Subject: [PATCH v2 0/4] STi DT updates
Message-ID: <1460469448-9065-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime / Patrice / Srini,

This series adds some more alternate pin configurations which were missing
upstream, the DT config for SSC12, and also a DT node for the at24c256 eeprom
to better describe the hardware on the I2C bus.

As at23c256 can now be accessed via nvmem framework it will allow stmmac driver to
be updated to obtain MAC address directlry from the eeprom.

regards,

Peter.

Changes in v2:
  - Add better patch description for 'STiH407: Add DT node for at24c256 eeprom'
    (Lee)
  - Rebase on v4.6-rc3 (Peter)

Peter Griffin (4):
  ARM: DT: STiH407: Add UART RTS/CTS pin configuration
  ARM: DT: STiH407: Add i2c12 pin definition
  ARM: DT: STiH407: Add node for i2c12 controller
  ARM: STi: DT: STiH407: Add DT node for at24c256 eeprom

 arch/arm/boot/dts/stih407-family.dtsi  | 13 ++++++
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 82 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi   |  9 ++++
 3 files changed, 104 insertions(+)

-- 
1.9.1
