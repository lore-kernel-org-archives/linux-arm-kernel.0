From: fabien.dessenne@st.com (Fabien Dessenne)
Date: Mon, 12 Mar 2018 11:58:25 +0100
Subject: [PATCH v2 0/2] mailbox: introduce STMicroelectronics STM32 IPCC driver
Message-ID: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STMicroelectronics STM32 Inter-Processor Communication Controller
(IPCC) is used for communicating data between two processors.
It provides a non blocking signaling mechanism to post and retrieve
communication data in an atomic way.

Changes since v2:
- update bindings and driver according to Rob's comments:
    - change compatible property to "st,stm32mp1-ipcc"
    - change "st,proc_id" property to "st,proc-id"
    - define all interrupts as mandatory

Fabien Dessenne (2):
  dt-bindings: mailbox: add STMicroelectronics STM32 IPCC binding
  mailbox: add STMicroelectronics STM32 IPCC driver

 .../devicetree/bindings/mailbox/stm32-ipcc.txt     |  47 +++
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/stm32-ipcc.c                       | 403 +++++++++++++++++++++
 4 files changed, 460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
 create mode 100644 drivers/mailbox/stm32-ipcc.c

-- 
2.7.4
