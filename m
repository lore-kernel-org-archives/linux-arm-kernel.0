From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sun,  1 Jul 2012 19:19:42 +0200
Subject: [PATCH 0/5] AT91SAM9G46/M11: add crypto drivers
Message-ID: <1341163187-14946-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch serie adds the support for the crypto engine available in
the Atmel SAM9G46 http://www.atmel.com/devices/SAM9G46.aspx and SAM9M11
http://www.atmel.com/devices/SAM9M11.aspx

For each driver the choice between PDC/DMA or PIO was optimized to
maximize the performances (benchmarks will soon be available on
the linux4sam wiki http://www.at91.com/).

These drivers were tested on both devices : the last patch adds a few
missing tests to tcrypt.

This work was sponsored by Atmel.

Nicolas Royer (5):
  ARM: AT91SAM9G45: add crypto peripherals
  crypto: add Atmel AES driver
  crypto: add Atmel DES/TDES driver
  crypto: add Atmel SHA1/SHA256 driver
  crypto: add new tests to tcrypt

 arch/arm/mach-at91/at91sam9g45.c              |   13 +-
 arch/arm/mach-at91/at91sam9g45_devices.c      |  128 +++
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 +
 crypto/tcrypt.c                               |   50 +-
 drivers/crypto/Kconfig                        |   47 +
 drivers/crypto/Makefile                       |    5 +-
 drivers/crypto/atmel-aes-regs.h               |   62 ++
 drivers/crypto/atmel-aes.c                    | 1206 ++++++++++++++++++++++++
 drivers/crypto/atmel-sha-regs.h               |   46 +
 drivers/crypto/atmel-sha.c                    | 1112 ++++++++++++++++++++++
 drivers/crypto/atmel-tdes-regs.h              |   89 ++
 drivers/crypto/atmel-tdes.c                   | 1215 +++++++++++++++++++++++++
 include/linux/platform_data/atmel-aes.h       |   22 +
 13 files changed, 3990 insertions(+), 7 deletions(-)
 create mode 100644 drivers/crypto/atmel-aes-regs.h
 create mode 100644 drivers/crypto/atmel-aes.c
 create mode 100644 drivers/crypto/atmel-sha-regs.h
 create mode 100644 drivers/crypto/atmel-sha.c
 create mode 100644 drivers/crypto/atmel-tdes-regs.h
 create mode 100644 drivers/crypto/atmel-tdes.c
 create mode 100644 include/linux/platform_data/atmel-aes.h

-- 
1.7.7.6
