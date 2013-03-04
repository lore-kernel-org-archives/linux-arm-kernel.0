From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 14:43:01 -0800
Subject: [PATCH 0/2] Call tracing/debug code in VFP preempt code
Message-ID: <1362436983-28988-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFP preempt enable/disable code doesn't call into the tracers
and also doesn't participate in the preempt debugging code. This
patchset fixes that by making calls to the C functions from assembly
when appropriate.

Stephen Boyd (2):
  ARM: Consolidate preempt enable/disable assembly into macros
  ARM: Enable tracing around vfp preemption enable/disable

 arch/arm/kernel/entry-header.S | 31 +++++++++++++++++++++++++++++++
 arch/arm/vfp/entry.S           | 20 +++-----------------
 arch/arm/vfp/vfphw.S           | 14 ++------------
 3 files changed, 36 insertions(+), 29 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
