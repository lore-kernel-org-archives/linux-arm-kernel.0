From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 13 Mar 2018 17:34:17 +0100
Subject: [PATCH 0/2] Introduce STM32MP1 Reset driver
Message-ID: <1520958859-27911-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set enables the reset of STM32MP1.
It uses the reset simple driver by introducing the clear register offset
parameter.
STM32MP1 reset IP has a register to assert by writing '1' and another
register to de-assert by writing '1'.
The offset between this two registers is '0x4'.

The patch 'dt-bindings: reset: add STM32MP1 resets' could be squashed
with the patch:
'dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings'
commit 3830681d354f

Gabriel Fernandez (2):
  dt-bindings: reset: add STM32MP1 resets
  reset: simple: Enable stm32mp1 reset driver

 drivers/reset/reset-simple.c                |  27 +++++--
 drivers/reset/reset-simple.h                |   1 +
 include/dt-bindings/reset/stm32mp1-resets.h | 108 ++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

-- 
1.9.1
