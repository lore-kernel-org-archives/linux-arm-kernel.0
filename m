From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Feb 2015 17:05:22 -0800
Subject: [PATCH 0/2] Scorpion PMU support
Message-ID: <1423616724-20849-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the Scorpion PMU found on devices
such as msm8660, qsd8x50, etc. The first patch is some groundwork
to make functions more "generic". Even then we end up copying quite
a bit of code from the Krait part into the Scorpion part with only
subtle tweaks because two things happen:

 1. We gain another "region" register, i.e. L2LPM
 2. The way to access the region registers are with different cp15 instructions

I'm not sure how to make this better, suggestions are welcome.

Stephen Boyd (2):
  ARM: perf: Preparatory work for Scorpion PMU support
  ARM: perf: Add support for Scorpion PMUs

 Documentation/devicetree/bindings/arm/pmu.txt |   2 +
 arch/arm/kernel/perf_event_cpu.c              |   2 +
 arch/arm/kernel/perf_event_v7.c               | 482 +++++++++++++++++++++++---
 3 files changed, 445 insertions(+), 41 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
