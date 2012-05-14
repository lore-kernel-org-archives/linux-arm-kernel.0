From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 14 May 2012 13:27:09 +0300
Subject: [PATCH] ARM: tegra: Fix flow controller accesses
Message-ID: <1336991229-18859-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flowctrl_write_cpu_csr uses the cpu halt offsets and vice versa. This patch
fixes this bug.

Reported-by: Dan Willemsen <dwillemsen@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/flowctrl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
index fef66a7..f07488e 100644
--- a/arch/arm/mach-tegra/flowctrl.c
+++ b/arch/arm/mach-tegra/flowctrl.c
@@ -53,10 +53,10 @@ static void flowctrl_update(u8 offset, u32 value)
 
 void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value)
 {
-	return flowctrl_update(flowctrl_offset_halt_cpu[cpuid], value);
+	return flowctrl_update(flowctrl_offset_cpu_csr[cpuid], value);
 }
 
 void flowctrl_write_cpu_halt(unsigned int cpuid, u32 value)
 {
-	return flowctrl_update(flowctrl_offset_cpu_csr[cpuid], value);
+	return flowctrl_update(flowctrl_offset_halt_cpu[cpuid], value);
 }
-- 
1.7.7.rc0.72.g4b5ea.dirty
