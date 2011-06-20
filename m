From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:40:25 +0100
Subject: [PATCH 0/4] Consistently enter the kernel in ARM state
Message-ID: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series rationalises the kernel entry requirements so that
Image is entered in ARM state, just like zImage.

This should enable Image to be booted reliably for Thumb-2 kernels,
just like zImage.

The Booting documentation is updated to describe the requirement:
this resolves the ARM/Thumb ambiguity for Thumb-2 kernels; for ARM
kernels there is no implied change.

Dave Martin (4):
  ARM: head: Always Enter the kernel in ARM state
  ARM: head-nommu: Always enter the kernel in ARM state
  ARM: zImage: Jump to the decompressed kernel entry point in ARM state
  ARM: Documentation: clarify entry requirements for ARM versus Thumb-2

 Documentation/arm/Booting       |    5 +++++
 arch/arm/boot/compressed/head.S |    3 ++-
 arch/arm/kernel/head-nommu.S    |    8 ++++++++
 arch/arm/kernel/head.S          |    8 ++++++++
 4 files changed, 23 insertions(+), 1 deletions(-)

-- 
1.7.4.1
