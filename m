From: julien.grall@arm.com (Julien Grall)
Date: Tue, 10 May 2016 15:40:31 +0100
Subject: [PATCH] arm64: cpuinfo: Missing NULL terminator in compat_hwcap_str
Message-ID: <1462891231-17605-1-git-send-email-julien.grall@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The loop that browses the array compat_hwcap_str will stop when a NULL
is encountered, however NULL is missing at the end of array. This will
result to overrun until one NULL is found somewhere in the memory.

Fixes: 44b82b7700d0 "arm64: Fix up /proc/cpuinfo"
Signed-off-by: Julien Grall <julien.grall@arm.com>
Cc: stable at vger.kernel.org

---

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpuinfo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 84c8684..f0c3fb7 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -87,7 +87,8 @@ static const char *const compat_hwcap_str[] = {
 	"idivt",
 	"vfpd32",
 	"lpae",
-	"evtstrm"
+	"evtstrm",
+	NULL
 };
 
 static const char *const compat_hwcap2_str[] = {
-- 
1.9.1
