From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 21:08:24 +0800
Subject: [PATCH v2 4/4] Document: Modify 8250 earlycon kernel parameters
In-Reply-To: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421068104-30463-5-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add options "noinit" to avoid init serial hardware in 8250_early.c

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 Documentation/kernel-parameters.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4df73da..03a4e9b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -948,7 +948,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			UART at the specified I/O port or MMIO address.
 			MMIO inter-register address stride is either 8-bit
 			(mmio) or 32-bit (mmio32).
-			The options are the same as for ttyS, above.
+			The options have two choices: one is the same as for
+			ttyS, above. The other is noinit, which means don't
+			initialize serial hardware, use the same setting as
+			loader.
 
 		pl011,<addr>
 			Start an early, polled-mode console on a pl011 serial
-- 
1.8.1.1.dirty
