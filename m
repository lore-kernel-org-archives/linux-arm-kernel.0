From: cosardindar@gmail.com (Cosar Dindar)
Date: Sat, 20 May 2017 16:30:18 +0300
Subject: [PATCH v2 0/5] Add support for the STM32F4 CRC32
Message-ID: <cover.1495285223.git.cosardindar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add hardware CRC32 ("Ethernet") calculation support
for STMicroelectronics STM32F429.

Polynomial and key setting are not supported, key is fixed as 0x4C11DB7
and poly is 0xFFFFFFFF.

Module is tested on STM32F429-disco board with crypto testmgr using
cases within the key 0xFFFFFFFF.

Cosar Dindar (5):
  crypto : stm32 - Add STM32F4 CRC32 support
  dt-bindings : Document the STM32F4 CRC32 binding
  ARM: dts: stm32: enable CRC32 on stm32429-disco board
  ARM: dts: stm32: enable CRC32 on stm32429i-eval board
  ARM: dts: stm32: Add CRC support to stm32f429

 .../devicetree/bindings/crypto/st,stm32-crc.txt    |  4 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |  4 ++
 arch/arm/boot/dts/stm32f429-disco.dts              |  4 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |  7 +++
 drivers/crypto/stm32/stm32_crc32.c                 | 68 ++++++++++++++++++----
 5 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.7.4
