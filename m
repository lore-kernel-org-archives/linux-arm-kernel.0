From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:34:26 +0000
Subject: [PATCH 06/11] ARM: sa11x0: fix section mismatch in cpu-sa1100.c
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu0Q-0002pf-BV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: arch/arm/mach-sa1100/built-in.o(.data+0x11b8): Section mismatch in reference from the variable sa1100_driver to the function .init.text:sa1100_cpu_init()
The variable sa1100_driver references
the function __init sa1100_cpu_init()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/cpu-sa1100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
index aaa8acf..19b2053 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/arch/arm/mach-sa1100/cpu-sa1100.c
@@ -228,7 +228,7 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct cpufreq_driver sa1100_driver = {
+static struct cpufreq_driver sa1100_driver __refdata = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= sa11x0_verify_speed,
 	.target		= sa1100_target,
-- 
1.7.4.4
