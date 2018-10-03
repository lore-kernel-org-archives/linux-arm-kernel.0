From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 3 Oct 2018 17:11:04 +0200
Subject: [PATCH 2/3] ARM: dts: stm32: don't use timers dmas on stm32mp157c-ed1
In-Reply-To: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
References: <1538579465-7854-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1538579465-7854-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spare dmas when using timer6 on stm32mp157c-ed1.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index f77bea4..c3ecb1e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -72,6 +72,9 @@
 
 &timers6 {
 	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
 	timer at 5 {
 		status = "okay";
 	};
-- 
1.9.1
