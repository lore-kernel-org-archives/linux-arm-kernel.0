From: bich.hemon@st.com (Bich HEMON)
Date: Thu, 13 Jul 2017 15:08:26 +0000
Subject: [PATCH 0/9] Add support for STM32H7 serial
Message-ID: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates existing stm32 usart driver:
- Misc fixes: copyright, mutliport management and timeout issue
- Add support for STM32H7
- Add support for wake-up and fifo management (for STM32H7)

Bich Hemon (2):
  serial: stm32: fix copyright
  serial: stm32: add RTS support

Fabrice Gasnier (3):
  serial: stm32: fix error handling in probe
  dt-bindings: serial: add compatible for stm32h7
  serial: stm32: add wakeup mechanism

Gerald Baeza (4):
  serial: stm32: fix multi-ports management
  serial: stm32: Increase maximum number of ports
  serial: stm32: fix pio transmit timeout
  serial: stm32: add fifo support

 .../devicetree/bindings/serial/st,stm32-usart.txt  |  17 ++-
 drivers/tty/serial/stm32-usart.c                   | 123 +++++++++++++++++++--
 drivers/tty/serial/stm32-usart.h                   |  37 ++++++-
 3 files changed, 162 insertions(+), 15 deletions(-)

-- 
1.9.1
