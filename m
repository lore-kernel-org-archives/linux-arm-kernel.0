From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Fri, 16 Oct 2015 11:07:04 -0300
Subject: [PATCH 0/2] Add support for NXP LPC18xx EEPROM using nvmem
Message-ID: <1445004426-6271-1-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for NXP LPC18xx EEPROM memory found in
NXP LPC SoCs family, which includes LPC18xx/LPC43xx. Other SoCs in
that family may share the same watchdog hardware.

This patchset is based on tag next-20151013 of the linux-next
repository. It has been successfully tested on a LPC4337 CIAA-NXP
Board.

EEPROM notes:
------------

EEPROM size is 16384 bytes and it can be entirely read and 
written/erased with 1 word (4 bytes) granularity. The last page
(128 bytes) contains the EEPROM initialization data and is not writable.

Erase/program time is less than 3ms. The EEPROM device requires a
~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
the system bus clock by the division factor, contained in the divider
register (minus 1 encoded).

Thanks,

Ariel D'Alessandro (2):
  nvmem: NXP LPC18xx EEPROM memory NVMEM driver
  DT: nvmem: Add NXP LPC18xx EEPROM memory binding documentation

 .../devicetree/bindings/nvmem/lpc18xx_eeprom.txt   |  26 ++
 drivers/nvmem/Kconfig                              |   9 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/lpc18xx_eeprom.c                     | 271 +++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/lpc18xx_eeprom.txt
 create mode 100644 drivers/nvmem/lpc18xx_eeprom.c

-- 
2.6.1
