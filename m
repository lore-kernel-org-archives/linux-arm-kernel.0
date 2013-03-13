From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Mar 2013 18:31:58 -0700
Subject: [PATCH 0/3] Detect UDIV/SDIV support from ISAR0
Message-ID: <1363138321-27849-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While attempting to upstream a patch to add the IDIV hwcap for
Krait processors, Will suggested we move the code to read the
ISAR0 register. This patchset does that and also works around
the early Krait CPU designs that don't follow the latest ARM ARM
for the ISAR0 register.

Stephen Boyd (3):
  ARM: Clear IDIVT hwcap if CONFIG_ARM_THUMB=n
  ARM: Detect support for SDIV/UDIV from ISAR0 register
  ARM: Work around faulty ISAR0 register in some Krait CPUs

 arch/arm/kernel/setup.c | 30 +++++++++++++++++++++++++++++-
 arch/arm/mm/proc-v7.S   |  4 ++--
 2 files changed, 31 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
