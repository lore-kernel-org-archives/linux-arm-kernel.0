From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  2 May 2013 11:49:42 +0100
Subject: [PATCH 0/8] crypto: Fix clocks and DMA configuration
Message-ID: <1367491790-9727-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set ensures any clocks that are obtained by the ux500
crypto drivers are prepared for use. We also request DMA channels and
configure them in the correct way using the new dmaengine API.

 arch/arm/mach-ux500/board-mop500.c    |   14 ++------------
 drivers/crypto/ux500/cryp/cryp.h      |    7 ++++++-
 drivers/crypto/ux500/cryp/cryp_core.c |   31 ++++++++++++++++++++++++++++++-
 drivers/crypto/ux500/hash/hash_alg.h  |    5 ++++-
 drivers/crypto/ux500/hash/hash_core.c |   24 ++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 17 deletions(-)
