From: anders.roxell@linaro.org (Anders Roxell)
Date: Mon, 27 Apr 2015 22:53:08 +0200
Subject: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
In-Reply-To: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Message-ID: <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the PMU interrupts as non-threadable, as is the case with
arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index aa29ecb..70dcde6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -461,7 +461,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 			}
 
 			err = request_irq(irq, armpmu->handle_irq,
-					IRQF_NOBALANCING,
+					IRQF_NOBALANCING | IRQF_NO_THREAD,
 					"arm-pmu", armpmu);
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
-- 
2.1.4
