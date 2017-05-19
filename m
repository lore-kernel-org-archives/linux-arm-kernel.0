From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 19 May 2017 08:53:22 +0200
Subject: [PATCH v2 0/9] crypto: add HMAC IPAD/OPAD constant
Message-ID: <20170519065331.27670-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Many HMAC users directly use directly 0x36/0x5c values.
It's better with crypto to use a name instead of directly some crypto constant.

Changes since v1:
- Moved constant to include/crypto/hmac.h
- Added <crypto/hmac.h> to includes

Corentin Labbe (9):
  crypto: add hmac IPAD/OPAD constant
  crypto: brcm - Use IPAD/OPAD constant
  crypto: ixp4xx - Use IPAD/OPAD constant
  crypto: marvell - Use IPAD/OPAD constant
  crypto: mv_cesa - Use IPAD/OPAD constant
  crypto: omap-sham - Use IPAD/OPAD constant
  crypto: qat - Use IPAD/OPAD constant
  crypto: mediatek - Use IPAD/OPAD constant
  crypto: ccp - Use IPAD/OPAD constant

 crypto/hmac.c                            | 5 +++--
 drivers/crypto/bcm/cipher.c              | 5 +++--
 drivers/crypto/ccp/ccp-crypto-sha.c      | 5 +++--
 drivers/crypto/ixp4xx_crypto.c           | 3 +--
 drivers/crypto/marvell/hash.c            | 5 +++--
 drivers/crypto/mediatek/mtk-sha.c        | 5 +++--
 drivers/crypto/mv_cesa.c                 | 5 +++--
 drivers/crypto/omap-sham.c               | 5 +++--
 drivers/crypto/qat/qat_common/qat_algs.c | 5 +++--
 include/crypto/hmac.h                    | 7 +++++++
 10 files changed, 32 insertions(+), 18 deletions(-)
 create mode 100644 include/crypto/hmac.h

-- 
2.13.0
