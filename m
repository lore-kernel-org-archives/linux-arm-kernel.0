From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 12 Jun 2013 09:41:06 -0700
Subject: [PATCH v2 1/3] arm: zynq: Remove board specific compatibility string
In-Reply-To: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371055268-32337-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1371055268-32337-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not necessary to have board specific compatibility strings
in the platform code. The board dts files can use the more generic
'xlnx,zynq-7000' string.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 5bfe703..7e3d5f4 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -98,7 +98,6 @@ static void zynq_system_reset(char mode, const char *cmd)
 }
 
 static const char * const zynq_dt_match[] = {
-	"xlnx,zynq-zc702",
 	"xlnx,zynq-7000",
 	NULL
 };
-- 
1.8.3
