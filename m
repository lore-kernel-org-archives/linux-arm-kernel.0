From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Mar 2013 11:28:54 -0700
Subject: [PATCHv2 0/3] Detect UDIV/SDIV support from ISAR0
Message-ID: <1363631337-13816-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While attempting to upstream a patch to add the IDIV hwcap for
Krait processors, Will suggested we move the code to read the
ISAR0 register. This patchset does that and also works around
the early Krait CPU designs that don't follow the latest ARM ARM
for the ISAR0 register.

Stepan Moskovchenko (1):
  ARM: Work around faulty ISAR0 register in some Krait CPUs

Stephen Boyd (2):
  ARM: Clear IDIVT hwcap if CONFIG_ARM_THUMB=n
  ARM: Detect support for SDIV/UDIV from ISAR0 register

 arch/arm/kernel/setup.c | 22 +++++++++++++++++++++-
 arch/arm/mm/proc-v7.S   | 19 +++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
