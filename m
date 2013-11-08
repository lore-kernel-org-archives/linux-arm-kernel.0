From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Nov 2013 16:08:09 +0100
Subject: [PATCH RESEND 0/7] crypto: at91/atmel: add Device Tree support
Message-ID: <cover.1383922546.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds Device Tree support to the Atmel crypto drivers 
(AES/[T]DES/SHA). The Device Tree entries are very simple and only
declare the reg/irq values and the link to DMA.

Some trivial patches are preceding this move to Device Tree to clean
things up beforehand.

The series has already been sent but a little bit scattered. So I collect
everything, this time.

Nicolas Ferre (7):
  ARM: at91/dt/trivial: use macro for AES irq type
  ARM: at91/dt/trivial: before sama5d3, Atmel MPU were using at91 prefix
  ARM: at91/dt/sama5d3: add DMA information to SHA/AES/TDES nodes
  crypto: atmel-aes - add support for Device Tree
  crypto: atmel-tdes - add support for Device Tree
  crypto: atmel-sha - add support for Device Tree
  crypto: atmel-sha - add sha information to the log

 .../devicetree/bindings/crypto/atmel-crypto.txt    |  68 ++++++++++
 arch/arm/boot/dts/sama5d3.dtsi                     |  16 ++-
 drivers/crypto/atmel-aes.c                         | 143 ++++++++++++++-------
 drivers/crypto/atmel-sha.c                         | 103 +++++++++++----
 drivers/crypto/atmel-tdes.c                        | 143 ++++++++++++++-------
 5 files changed, 346 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

-- 
1.8.2.2
