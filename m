From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 30 Jan 2015 15:54:24 -0700
Subject: [PATCH 0/2] Coresight Support for arm64 
Message-ID: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Other than tracers, the coresight IP blocks are 64-bit ready.  This
would normally be a trivial addition had it not been for the first
patch that is adding cpu index lookup functionality.

The feature exists in the 32 world and the fact that it doesn't on
64 bit means that 1) nobody needed it as of yet or 2) people have found
a different way to proceed.

Please have a look and tell me what you think.

Many thanks,
Mathieu

Mathieu Poirier (2):
  arm64: adding cpu lookup functionality
  coresight: Adding coresight support to arm64

 arch/arm64/Kconfig.debug            | 48 +++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/smp_plat.h   | 12 ++++++++++
 drivers/coresight/coresight-etb10.c |  2 +-
 drivers/coresight/coresight-tmc.c   |  2 +-
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
1.9.1
