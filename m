From: wzz@rock-chips.com (zain wang)
Date: Mon, 24 Jul 2017 09:23:12 +0800
Subject: [RESEND PATCH 0/2] crypto/rockchip: fix some issue which causes
 crypto failed
Message-ID: <1500859394-1799-1-git-send-email-wzz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix some bugs on rockchip's crypto which would cause crypto failed.

zain wang (2):
  crypto: rockchip - move the crypto completion from interrupt context
  crypto: rockchip - return the err code when unable dequeue the crypto
    request

 drivers/crypto/rockchip/rk3288_crypto.c            | 58 +++++++++++-----------
 drivers/crypto/rockchip/rk3288_crypto.h            |  4 +-
 drivers/crypto/rockchip/rk3288_crypto_ablkcipher.c | 17 ++++++-
 drivers/crypto/rockchip/rk3288_crypto_ahash.c      | 16 +++++-
 4 files changed, 62 insertions(+), 33 deletions(-)

-- 
1.9.1
