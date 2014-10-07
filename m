From: seraphin.bonnaffe@st.com (Seraphin Bonnaffe)
Date: Tue, 7 Oct 2014 15:22:27 +0200
Subject: [RFC PATCH 1/2] mfd: syscon: Document new DT binding "holes"
In-Reply-To: <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
References: <54244655.1090801@st.com>
 <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
Message-ID: <1412688148-20835-2-git-send-email-seraphin.bonnaffe@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT bindings to declare holes in syscon register maps.

Signed-off-by: Seraphin Bonnaffe <seraphin.bonnaffe@st.com>
---
 Documentation/devicetree/bindings/mfd/syscon.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index fe8150b..80ab9ca 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -13,8 +13,13 @@ Required properties:
 - compatible: Should contain "syscon".
 - reg: the register region can be accessed from syscon
 
+Optional properties:
+- holes: Register regions that cannot be accessed within reg range.
+	 Each hole is described with its offset address, followed by its size.
+
 Examples:
 gpr: iomuxc-gpr at 020e0000 {
 	compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
 	reg = <0x020e0000 0x38>;
+	holes = <0x000c 0x8 0x020 0x4>;
 };
-- 
1.9.1
