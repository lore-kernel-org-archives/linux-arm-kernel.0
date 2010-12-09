From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  9 Dec 2010 11:59:40 +0000
Subject: [PATCH 0/2] ARM: Thumb-2: Fix Kconfig rules to avoid nonworking
	configs
Message-ID: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some configurations don't make sense with Thumb-2, or don't
currently work and are unlikely to be relevant.

The patches avoid Kconfig from allowing these problematic
combinations, for now.

Dave Martin (2):
  ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
  ARM: Make CONFIG_FPE_NWFPE depend on !CONFIG_THUMB2_KERNEL

 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
