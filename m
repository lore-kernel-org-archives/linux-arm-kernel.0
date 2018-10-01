From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon,  1 Oct 2018 13:27:46 -0700
Subject: [PATCH i2c-next v4 1/3] dt-bindings: i2c: aspeed: Add 'timeout'
 property as an optional property
In-Reply-To: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20181001202748.8030-2-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds 'timeout' property as an optional property which
can be used for setting 'timeout' value of 'struct i2c_adapter'.
With this patch, the bus timeout value can be set through this
DT property from the probing time of the module. Still the bus
timeout value can be set by an I2C_TIMEOUT ioctl on cdev at
runtime too.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd8633a387..1789502818c2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -17,6 +17,9 @@ Optional Properties:
 		  specified
 - multi-master	: states that there is another master active on this bus.
 
+- timeout	: I2C bus timeout in milliseconds defaults to 1 second when not
+		  specified.
+
 Example:
 
 i2c {
-- 
2.19.0
