From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Oct 2014 18:35:30 +0100
Subject: [PATCH 0/1] bus: cci: move away from arm_pmu framework
Message-ID: <1413826531-23462-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch migrates the CCI PMU away from the arm_pmu framework, in
preparation for future changes to the arm_pmu framework which will be
incompatible with system PMUs.

It turns out that supporting CPU-affine and system-wide PMUs through the
intermediary arm_pmu framework is becoming increasingly painful. The two
classes of PMU have rather different requirements and attempting to
support both is resulting in a sub-par support either side.

So as to enable future CPU PMU developments (including big.LITTLE
support), move the CCI PMU away from the arm_pmu framework. Hopefully we
can librify common system PMU functionality over time.

Thanks,
Mark.

Mark Rutland (1):
  bus: cci: move away from arm_pmu framework

 drivers/bus/arm-cci.c | 549 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 441 insertions(+), 108 deletions(-)

-- 
1.9.1
