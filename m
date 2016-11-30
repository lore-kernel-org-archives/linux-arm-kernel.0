From: rob.rice@broadcom.com (Rob Rice)
Date: Wed, 30 Nov 2016 15:07:30 -0500
Subject: [PATCH 0/3] Add Broadcom SPU Crypto Driver
Message-ID: <1480536453-24781-1-git-send-email-rob.rice@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom SPU crypto driver provides access to SPU hardware
for symmetric crypto offload. The driver supports ablkcipher,
ahash, and aead operations. The driver supports several
Broadcom SoCs with different revisions of the SPU hardware.
The driver supports SPU-M and SPU2 hardware revisions, and
a couple versions of each hw revision, each version with minor
differences.

The device tree entries for the SPU depends on device tree entries
for the Broadcom PDC driver. The PDC DT entries have been accepted
upstream, but are not yet included in the crypto repo. See commit
e79249143f468f8d3365dbbd1642c045bdcc98c5.

Rob Rice (3):
  crypto: brcm: DT documentation for Broadcom SPU driver
  crypto: brcm: Add Broadcom SPU driver
  crypto: brcm: Add Broadcom SPU driver DT entry.

 .../devicetree/bindings/crypto/brcm,spu-crypto.txt |   25 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   12 +
 drivers/crypto/Kconfig                             |   10 +
 drivers/crypto/Makefile                            |    1 +
 drivers/crypto/bcm/Makefile                        |   15 +
 drivers/crypto/bcm/cipher.c                        | 4943 ++++++++++++++++++++
 drivers/crypto/bcm/cipher.h                        |  472 ++
 drivers/crypto/bcm/spu.c                           | 1252 +++++
 drivers/crypto/bcm/spu.h                           |  288 ++
 drivers/crypto/bcm/spu2.c                          | 1402 ++++++
 drivers/crypto/bcm/spu2.h                          |  228 +
 drivers/crypto/bcm/spum.h                          |  174 +
 drivers/crypto/bcm/util.c                          |  584 +++
 drivers/crypto/bcm/util.h                          |  117 +
 14 files changed, 9523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/brcm,spu-crypto.txt
 create mode 100644 drivers/crypto/bcm/Makefile
 create mode 100644 drivers/crypto/bcm/cipher.c
 create mode 100644 drivers/crypto/bcm/cipher.h
 create mode 100644 drivers/crypto/bcm/spu.c
 create mode 100644 drivers/crypto/bcm/spu.h
 create mode 100644 drivers/crypto/bcm/spu2.c
 create mode 100644 drivers/crypto/bcm/spu2.h
 create mode 100644 drivers/crypto/bcm/spum.h
 create mode 100644 drivers/crypto/bcm/util.c
 create mode 100644 drivers/crypto/bcm/util.h

--
2.1.0
