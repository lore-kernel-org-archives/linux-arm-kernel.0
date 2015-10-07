From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 09:30:05 +0900
Subject: [RFT 1/3] dt-bindings: usb: usb5303: Document new 'phys' property
In-Reply-To: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
References: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1444177807-15524-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new 'phys' and 'phys-names' properties.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: riku.voipio at linaro.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/usb/usb3503.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb3503.txt b/Documentation/devicetree/bindings/usb/usb3503.txt
index 52493b1480e2..773c8d722c13 100644
--- a/Documentation/devicetree/bindings/usb/usb3503.txt
+++ b/Documentation/devicetree/bindings/usb/usb3503.txt
@@ -15,6 +15,8 @@ Optional properties:
 - reset-gpios: Should specify GPIO for reset.
 - initial-mode: Should specify initial mode.
                 (1 for HUB mode, 2 for STANDBY mode)
+- phys: One PHY specifier (refer to generic PHY bindings).
+- phy-names: If 'phys' is present, then it must be 'usb2-phy'.
 - refclk: Clock used for driving REFCLK signal (optional, if not provided
 	the driver assumes that clock signal is always available, its
 	rate is specified by REF_SEL pins and a value from the primary
@@ -33,4 +35,6 @@ Examples:
 		intn-gpios = <&gpx3 4 1>;
 		reset-gpios = <&gpx3 5 1>;
 		initial-mode = <1>;
+		phys = <&usb2_phy_gen 3>;
+		phy-names = "usb2-phy";
 	};
-- 
1.9.1
