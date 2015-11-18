From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 17:03:53 +0000
Subject: [PATCH 0/5] arm64: cpufeature: Fixes for 4.4-rc1
Message-ID: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series contains fixes for two issues.

 Patches 1 - 3:	Handling of unsigned feature values, issu reported
		by AKASHI Takahiro.

 Patches 4 - 5:	Adds a check to make sure all the secondary CPUs have
		compatible ASIDBits to prevent system crashes.

Suzuki K. Poulose (5):
  arm64: cpufeature: Add helpers for extracting unsigned values
  arm64: cpufeature: Track unsigned fields
  arm64: debug: Treat the BRPs/WRPs as unsigned
  arm64: Make fail_incapable_cpu reusable
  arm64: Ensure the secondary CPUs have safe ASIDBits size

 arch/arm64/include/asm/cpufeature.h    |   22 +++++-
 arch/arm64/include/asm/hw_breakpoint.h |    6 +-
 arch/arm64/kernel/cpufeature.c         |  132 ++++++++++++++++++++++----------
 3 files changed, 116 insertions(+), 44 deletions(-)

-- 
1.7.9.5
