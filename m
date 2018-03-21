From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Wed, 21 Mar 2018 17:48:54 +0100
Subject: [PATCH v2 0/6] Add different features for I2C
Message-ID: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append new I2C STM32F7 feature set. This includes 10 bit support, slave
support, SMBBus protocols support, DMA Support and eventually an I2C recovery
mechanism.

---
  Version history:
    v1:
        * Initial
    v2:
        * Kbuild test robot issue
        * I2C master recovery mechanism 
---
Pierre-Yves MORDRET (6):
  i2c: i2c-stm32f7: Add 10-bit address support
  i2c: i2c-stm32f7: Add slave support
  i2c: i2c-stm32f7: Add initial SMBus protocols support
  i2c: i2c-stm32: Add generic DMA API
  i2c: i2c-stm32f7: Add DMA support
  i2c: i2c-stm32f7: Implement I2C recovery mechanism

 drivers/i2c/busses/Kconfig       |    1 +
 drivers/i2c/busses/Makefile      |    3 +-
 drivers/i2c/busses/i2c-stm32.c   |  153 ++++++
 drivers/i2c/busses/i2c-stm32.h   |   37 ++
 drivers/i2c/busses/i2c-stm32f7.c | 1040 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 1207 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c

-- 
2.7.4
