From: maninder1.s@samsung.com (Maninder Singh)
Date: Mon, 06 Jul 2015 12:02:11 +0530
Subject: [PATCH 1/1] arm64: use pr_warn instead of pr_warning
Message-ID: <1436164331-3736-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use more commonly used pr_warn, and also code looks similar 
to arm/hw_breakpoint.c code after this change.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 arch/arm64/kernel/hw_breakpoint.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index e7d934d..f703609 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -72,7 +72,7 @@ int hw_breakpoint_slots(int type)
 	case TYPE_DATA:
 		return get_num_wrps();
 	default:
-		pr_warning("unknown slot type: %d\n", type);
+		pr_warn("unknown slot type: %d\n", type);
 		return 0;
 	}
 }
@@ -133,7 +133,8 @@ static u64 read_wb_reg(int reg, int n)
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_READ_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to read from unknown breakpoint register %d\n", n);
+		pr_warn("attempt to read from unknown breakpoint register %d\n",
+			 n);
 	}
 
 	return val;
@@ -147,7 +148,8 @@ static void write_wb_reg(int reg, int n, u64 val)
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WVR, AARCH64_DBG_REG_NAME_WVR, val);
 	GEN_WRITE_WB_REG_CASES(AARCH64_DBG_REG_WCR, AARCH64_DBG_REG_NAME_WCR, val);
 	default:
-		pr_warning("attempt to write to unknown breakpoint register %d\n", n);
+		pr_warn("attempt to write to unknown breakpoint register %d\n",
+			 n);
 	}
 	isb();
 }
@@ -164,7 +166,7 @@ static enum debug_el debug_exception_level(int privilege)
 	case AARCH64_BREAKPOINT_EL1:
 		return DBG_ACTIVE_EL1;
 	default:
-		pr_warning("invalid breakpoint privilege level %d\n", privilege);
+		pr_warn("invalid breakpoint privilege level %d\n", privilege);
 		return -EINVAL;
 	}
 }
-- 
1.7.9.5
