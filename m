From: lionel.debieve@st.com (Lionel Debieve)
Date: Thu, 13 Jul 2017 15:06:30 +0200
Subject: [PATCH 0/3] STM32 CRC update
Message-ID: <1499951193-14842-1-git-send-email-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches update the STM32 CRC driver.
It contains two corrections and one global Kconfig rework.
First correction is about the relaxed usage in scope of arm
platform usage, second about a unbind driver issue.
Last patch is about a Kconfig rework that make configuration
generic for STM32 crypto algos, HASH and CRYP are pushed
accordingly.

Lionel Debieve (3):
  crypto: stm32 - CRC use relaxed function
  crypto: stm32 - solve crc issue during unbind
  crypto: stm32 - Rename module to use generic crypto

 drivers/crypto/Makefile            |  2 +-
 drivers/crypto/stm32/Kconfig       |  6 +++---
 drivers/crypto/stm32/Makefile      |  3 +--
 drivers/crypto/stm32/stm32_crc32.c | 17 +++++++++--------
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.7.4
