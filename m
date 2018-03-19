From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Mon, 19 Mar 2018 08:25:49 +0100
Subject: [PATCH v3 0/2] Introduce STM32MP1 Reset driver
Message-ID: <1521444351-29550-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v3:
remove unused includes
fix status ops
fix from Fengguang Wu
	for Kbuild test robot: symbol 'stm32_reset_ops' was not declared. Should it be static?
use 'builtin_platform_driver' instead 'postcore_initcall'

v2:
Don't use reset-simple driver but a custom reset driver.
add dt-binding documentation.

This patch-set enables the reset of STM32MP1.
STM32MP1 reset IP has a register to assert by writing '1' and another
register to de-assert by writing '1'.

The patch 'dt-bindings: reset: add STM32MP1 resets' could be squashed
with the patch:
'dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings'
commit 3830681d354f

Gabriel Fernandez (2):
  dt-bindings: reset: add STM32MP1 resets
  reset: stm32mp1: Enable stm32mp1 reset driver

 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 ++
 drivers/reset/Kconfig                              |   6 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32mp1.c                     | 115 +++++++++++++++++++++
 include/dt-bindings/reset/stm32mp1-resets.h        | 108 +++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
 create mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

-- 
1.9.1
