From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu,  1 Aug 2013 13:13:31 +0100
Subject: [PATCH 1/2] ARM: STi: Fix cpu nodes with correct device_type.
In-Reply-To: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
References: <1375359131-21693-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1375359211-21785-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes cpu nodes with device_type = "cpu". This change was not
necessary before 3.10-rc7.
Without this patch STi SOCs does not boot as SMP.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/boot/dts/stih41x.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/stih41x.dtsi b/arch/arm/boot/dts/stih41x.dtsi
index 7321403..f5b9898 100644
--- a/arch/arm/boot/dts/stih41x.dtsi
+++ b/arch/arm/boot/dts/stih41x.dtsi
@@ -6,10 +6,12 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		cpu at 0 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 		};
 		cpu at 1 {
+			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 		};
-- 
1.7.6.5
