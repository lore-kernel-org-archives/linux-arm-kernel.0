From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  3 Oct 2014 13:52:02 +0200
Subject: [PATCH v2 2/5] dt-bindings: Add a clocks property to the
 simple-framebuffer binding
In-Reply-To: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1412337125-14388-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A simple-framebuffer node represents a framebuffer setup by the firmware /
bootloader. Such a framebuffer may have a number of clocks in use, add a
property to communicate this to the OS.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mike Turquette <mturquette@linaro.org>
---
 Documentation/devicetree/bindings/video/simple-framebuffer.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 70c26f3..e75478e 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -14,6 +14,9 @@ Required properties:
   - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
   - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
 
+Optional properties:
+- clocks : List of clocks used by the framebuffer
+
 Example:
 
 	framebuffer {
-- 
2.1.0
