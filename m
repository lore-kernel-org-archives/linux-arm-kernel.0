From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 15 Jun 2015 21:19:56 +0530
Subject: [PATCH-V2 09/12] Documentation: binding: add new property
 'disable_after_xfer' to i2c-pxa
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <1434383399-2370-10-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver now supports enable/disable across msg xfer, which user
can control it by new DT property -

i2c-disable-after-xfer : If set, driver will disable I2C module after msg
 xfer and enable it back before xfer.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 12b78ac..9657db5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -18,6 +18,11 @@ Recommended properties :
    status register of i2c controller instead.
  - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
 
+Optional properties :
+
+ - i2c-disable-after-xfer : If set, driver will disable I2C module
+   after msg xfer and enable it again before xfer.
+
 Examples:
 	twsi1: i2c at d4011000 {
 		compatible = "mrvl,mmp-twsi";
-- 
1.9.1
