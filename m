From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 12 Jan 2017 15:20:07 +0000
Subject: [PATCH v3 0/3] arm64: dts: juno: CoreSight support updates
Message-ID: <1484234410-7670-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

I just did some refactoring to reduced thge churn and duplication.
Can you check if this work for you ? I could not give it much testing.

Regards,
Sudeep

--->8
Juno r1/r2 boards have different CoreSight infrastructure outside the
CPU clusters. This patchset adds the additional coreSight components to
separate .dtsi files to support these differences.

v1->v2:
	- moved the addition of the STM component into a separate patch

v2->v3:
	- moved the back the common coreSight components back into
	  juno-base.dtsi


Mike Leach (2):
  arm64: dts: juno: fix CoreSight support for Juno r1/r2 variants
  arm64: dts: juno: add missing CoreSight STM component

Sudeep Holla (1):
  arm64: dts: juno: refactor CoreSight support on Juno r0

 arch/arm64/boot/dts/arm/juno-base.dtsi    |  31 ++++++---
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 102 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/arm/juno-r1.dts       |  13 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts       |  13 ++++
 arch/arm64/boot/dts/arm/juno.dts          |  24 +++++++
 5 files changed, 175 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi

--
2.7.4
