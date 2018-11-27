From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 27 Nov 2018 17:48:15 +0100
Subject: [PATCH 1/3] dt-bindings: mfd: syscon: Add optional clock support
In-Reply-To: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1543337297-21873-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some system control registers need to be clocked, so the registers can
be accessed. Add an optional clock.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/mfd/syscon.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon.txt
index 25d9e9c..a9aaa51 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/syscon.txt
@@ -17,6 +17,7 @@ Optional property:
 - reg-io-width: the size (in bytes) of the IO accesses that should be
   performed on the device.
 - hwlocks: reference to a phandle of a hardware spinlock provider node.
+- clocks: phandle to the syscon clock
 
 Examples:
 gpr: iomuxc-gpr at 20e0000 {
-- 
1.9.1
