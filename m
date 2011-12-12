From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 12 Dec 2011 11:42:30 +0800
Subject: [PATCH 5/7] arm/imx: add cpu_voltage to cpu_op
In-Reply-To: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323661352-10291-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Help cpu_op table have cpu_voltage info and cpufreq driver
to change cpu voltage.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/include/mach/mxc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index a4d36d6..1ff7fe7 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -166,6 +166,7 @@ extern unsigned int __mxc_cpu_type;
 
 struct cpu_op {
 	u32 cpu_rate;
+	int cpu_voltage;
 };
 
 int tzic_enable_wake(int is_idle);
-- 
1.7.5.4
