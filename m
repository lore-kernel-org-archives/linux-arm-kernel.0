From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 10:07:41 +0200
Subject: [PATCH 1/4] dt-bindings: display: amlogic,
 meson-vpu: Add optional power domain property
In-Reply-To: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
References: <1508227664-11171-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1508227664-11171-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Video Processing Unit power domain was setup by the Vendor U-Boot,
add support for an optional Power Domain phandle to setup it from the kernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index 00f74ba..057b813 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -64,6 +64,10 @@ Required properties:
 - reg-names: should contain the names of the previous memory regions
 - interrupts: should contain the VENC Vsync interrupt number
 
+Optional properties:
+- power-domains: Optional phandle to associated power domain as described in
+	the file ../power/power_domain.txt
+
 Required nodes:
 
 The connections to the VPU output video ports are modeled using the OF graph
-- 
2.7.4
