From: horia.geanta@freescale.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Fri, 28 Aug 2015 14:45:06 +0300
Subject: [RFC][PATCH 0/2] crypto: caam - Revamp I/O accessors
Message-ID: <1440762306-7764-1-git-send-email-horia.geanta@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Part of the) I/O accessors in caam driver are PPC-specific.
Use io{read,write}XX[be] instead.

While here, prepare for "mixed" endianness platforms (like ARMv8-based
LS1043A), where caam endianness (big) does not match the endianness
of the core (little).

1st patch adds 64-bit accessors for arm64.

2nd patch updates the I/O accessors in the caam driver.

Horia Geant? (2):
  arm64: add ioread64be and iowrite64be macros
  crypto: caam - handle core endianness != caam endianness

 arch/arm64/include/asm/io.h       |  4 ++-
 drivers/crypto/caam/caamhash.c    |  5 +--
 drivers/crypto/caam/ctrl.c        |  2 +-
 drivers/crypto/caam/desc.h        |  9 ++++-
 drivers/crypto/caam/desc_constr.h | 42 +++++++++++++++--------
 drivers/crypto/caam/jr.c          |  8 ++---
 drivers/crypto/caam/regs.h        | 72 ++++++++++++++++++++++++++++-----------
 drivers/crypto/caam/sg_sw_sec4.h  | 10 +++---
 8 files changed, 105 insertions(+), 47 deletions(-)

-- 
2.4.4
