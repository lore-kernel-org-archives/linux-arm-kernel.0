From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  8 Sep 2014 09:57:05 +0900
Subject: [PATCH v3 0/3] ARM: shmobile: sh73a0: Enable CMT1 device using DT
Message-ID: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is a slightly modified version of this change which
was previously available in
"[PATCH v2 00/10] sh73a0 common clock framework implementation"

The purpose of breaking or this change is to allow it to
be applied independently of the changes in the above mentioned series.

The changes are as follows:
- Don't use DT clocks as they are added by the above mentioned series
  and thus not present yet.
- Add patch to use SoC-specific 48-bit CMT compat string.

Simon Horman (1):
  ARM: shmobile: sh73a0: Use SoC-specific 48-bit CMT compat string

Ulrich Hecht (2):
  ARM: shmobile: sh73a0: Add CMT1 device to DT
  ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
 arch/arm/boot/dts/sh73a0.dtsi                | 10 ++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.0.1
