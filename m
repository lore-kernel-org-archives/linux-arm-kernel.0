From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 18:33:46 +0100
Subject: [PATCH 0/3] crypto: Clean up ahash handling confusion
Message-ID: <1389720829-5963-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches shall clean up the confusion in restoring the ahash request
context in crypto/ahash.c . The code was a bit refactored to make it easier to
understand as well.

Please, make sure the code is well tested before applying. Also, please review
very thoroughly.

Marek Vasut (3):
  crypto: Fix the pointer voodoo in unaligned ahash
  crypto: Pull out the functions to save/restore request
  crypto: Simplify the ahash_finup implementation

 crypto/ahash.c | 172 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 110 insertions(+), 62 deletions(-)

Cc: David S. Miller <davem@davemloft.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
-- 
1.8.5.2
