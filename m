From: bintian.wang@huawei.com (Bintian Wang)
Date: Thu, 7 May 2015 22:00:23 +0800
Subject: [PATCH v5 4/6] Documentation: DT: PL011: hi6220: add compatible
 string for Hisilicon designed UART
In-Reply-To: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
References: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1431007225-8513-5-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hisilicon does some performance enhancements based on PL011(e.g. larger
FIFO length), so add one compatible string "hisilicon,hi6220-uart" for
future optimisations or workarounds works.

Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/devicetree/bindings/serial/pl011.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
index ba3ecb8..cb9fd9d 100644
--- a/Documentation/devicetree/bindings/serial/pl011.txt
+++ b/Documentation/devicetree/bindings/serial/pl011.txt
@@ -1,7 +1,9 @@
 * ARM AMBA Primecell PL011 serial UART
 
 Required properties:
-- compatible: must be "arm,primecell", "arm,pl011"
+- compatible: should contain one of the following sequences:
+  * "arm,pl011", "arm,primecell"
+  * "hisilicon,hi6220-pl011", "arm,pl011", "arm,primecell"
 - reg: exactly one register range with length 0x1000
 - interrupts: exactly one interrupt specifier
 
-- 
1.7.9.5
