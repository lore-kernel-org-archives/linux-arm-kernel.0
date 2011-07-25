From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sun, 24 Jul 2011 18:15:14 -0700
Subject: [PATCH] Documentation: Document ARM's user_debug parameter
Message-ID: <1311556514-24728-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usually kernel parameters are documented in kernel-parameters.txt
but user_debug is only documented in the Kconfig. Document the
option and point to the Kconfig help text for more info.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 Documentation/kernel-parameters.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index aa47be7..8186adc 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2612,6 +2612,16 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 					medium is write-protected).
 			Example: quirks=0419:aaf5:rl,0421:0433:rc
 
+	user_debug=	[KNL,ARM]
+			Format: <int>
+			See arch/arm/Kconfig.debug help text.
+				 1 - undefined instruction events
+				 2 - system calls
+				 4 - invalid data aborts
+				 8 - SIGSEGV faults
+				16 - SIGBUS faults
+			Example: user_debug=31
+
 	userpte=
 			[X86] Flags controlling user PTE allocations.
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
