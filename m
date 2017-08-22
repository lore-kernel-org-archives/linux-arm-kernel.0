From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:07 +0200
Subject: [PATCH 00/11] crypto: gcm - add GCM IV size constant
Message-ID: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many GCM users use directly GCM IV size instead of using some constant.

This patch add all IV size constant used by GCM and convert drivers for using them..

Corentin Labbe (11):
  crypto: gcm - add GCM iv size constant
  crypto: caam - Use GCM IV size constant
  crypto: ccp - Use GCM IV size constant
  crypto: nx - Use GCM IV size constant
  crypto: atmel - Use GCM IV size constant
  crypto: bcm - Use GCM IV size constant
  crypto: mediatek - Use GCM IV size constant
  crypto: chelsio - Use GCM IV size constant
  crypto: omap - Use GCM IV size constant
  crypto: gcm - Use GCM IV size constant
  crypto: aesni - Use GCM IV size constant

 arch/x86/crypto/aesni-intel_glue.c         |  7 ++++---
 crypto/gcm.c                               | 23 ++++++++++++-----------
 drivers/crypto/atmel-aes.c                 |  5 +++--
 drivers/crypto/bcm/cipher.c                |  8 ++++----
 drivers/crypto/bcm/cipher.h                |  3 +--
 drivers/crypto/caam/caamalg.c              | 10 +++++-----
 drivers/crypto/caam/compat.h               |  1 +
 drivers/crypto/ccp/ccp-crypto-aes-galois.c |  9 ++++-----
 drivers/crypto/chelsio/chcr_algo.c         |  9 +++++----
 drivers/crypto/mediatek/mtk-aes.c          |  3 ++-
 drivers/crypto/nx/nx-aes-gcm.c             |  9 +++++----
 drivers/crypto/omap-aes-gcm.c              |  7 ++++---
 drivers/crypto/omap-aes.c                  |  5 +++--
 include/crypto/gcm.h                       |  8 ++++++++
 14 files changed, 61 insertions(+), 46 deletions(-)
 create mode 100644 include/crypto/gcm.h

-- 
2.13.0
