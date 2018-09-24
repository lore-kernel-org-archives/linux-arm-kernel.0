From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 24 Sep 2018 16:04:41 -0700
Subject: [PATCH i2c-next v2 1/2] dt-bindings: i2c: aspeed: Add
 'idle-wait-timeout-ms' property
In-Reply-To: <20180924230442.7732-1-jae.hyun.yoo@linux.intel.com>
References: <20180924230442.7732-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180924230442.7732-2-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds 'idle-wait-timeout-ms' property which can be used
for bus idle waiting logic in multi-master environment.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd8633a387..42ecaaf67172 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -13,9 +13,13 @@ Required Properties:
 - interrupts		: interrupt number
 
 Optional Properties:
-- bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
-		  specified
-- multi-master	: states that there is another master active on this bus.
+- bus-frequency		: frequency of the bus clock in Hz defaults to 100 kHz
+			  when not specified
+- multi-master		: states that there is another master active on this
+			  bus.
+- idle-wait-timeout-ms	: bus idle waiting timeout in milliseconds when
+			  multi-master is set, defaults to 100 ms when not
+			  specified.
 
 Example:
 
-- 
2.18.0
