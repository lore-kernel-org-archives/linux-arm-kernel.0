From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:26:56 +0100
Subject: [PATCH 0/9] Fix ux500 crypto drivers and init DMA in the correct way 
Message-ID: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These drivers haven't been touched in a while. They didn't even compile
or probe successfully. After these changes, both drivers run just fine.

We also split DMA channel allocation and configuration into separate
invocations, as the API expects.

 arch/arm/mach-ux500/board-mop500.c    |   14 ++------------
 drivers/crypto/ux500/cryp/cryp.h      |    7 ++++++-
 drivers/crypto/ux500/cryp/cryp_core.c |   27 +++++++++++++++++++++++----
 drivers/crypto/ux500/hash/hash_alg.h  |    5 ++++-
 drivers/crypto/ux500/hash/hash_core.c |   20 +++++++++++++++-----
 5 files changed, 50 insertions(+), 23 deletions(-)
