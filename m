From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  8 Jan 2016 11:24:07 +0000
Subject: [RESEND PATCH 0/2] crypto: sunxi-ss: fix 64-bit compilation
Message-ID: <1452252249-12040-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resending to add linux-crypto, patches unchanged)

Hi,

these two patches provide a different approach to an issue I tried
to fix lately [1].
Instead of casting everything I now promote local types to size_t, so
that the min3() arguments naturally match in type.
As size_t is defined as "unsigned int" on 32-bit architectures
anyway, that actually does not change anything there, but instead
provides a clean approach to get it compiled for arm64.

I split this up because 1/2 seems much cleaner to me than 2/2, so we
can have a separate discussion/merge process on this.

Cheers,
Andre.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/395689.html

Andre Przywara (2):
  crypto: sunxi-ss-cipher: promote variables to match types in min3()
    calls
  crypto: sunxi-ss-hash: promote variables to match types in min3()
    calls

 drivers/crypto/sunxi-ss/sun4i-ss-cipher.c | 20 ++++++++++----------
 drivers/crypto/sunxi-ss/sun4i-ss-hash.c   | 12 ++++++------
 drivers/crypto/sunxi-ss/sun4i-ss.h        |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.6.4
