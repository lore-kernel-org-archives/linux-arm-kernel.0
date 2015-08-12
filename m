From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 12 Aug 2015 12:42:30 +0800
Subject: [PATCH v16 2/4] ARM: power-domain: rockchip: add all the domain type
 on RK3288 SoCs
In-Reply-To: <1439354552-20098-1-git-send-email-wxt@rock-chips.com>
References: <1439354552-20098-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1439354552-20098-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to a description from TRM, the following table lists
all the power domains.

------------------------   -------------------------
|VD_CORE               |   |VD_LOGIC    |  PD_VIO  |
|xxxxxxxxxxxxxxxxxxxx  |   |xxxxxxxx    -----------|
|xxxxxxxxxxxxxxxxxxxx  |   |xxxxxxxx               |
|xxxxxxxxxxxxxxxxxxxx  |   |                       |
|xxxxxxxxxxxxxxxxxxxx  |   |---------   -----------|
|                      |   |PD_PERI  |  | PD_VIDEO |
|                      |   |---------   -----------|
|                      |   |---------   -----------|
|                      |   |PD_ALIVE |  | PD_HEVC  |
|---------- ---------- |   |---------   -----------|
||PD_A17_1| |PD_A17_2| |   -------------------------
|---------- ---------- |   |VD_GPU      |PD_GPU    |
|---------- ---------- |   -------------------------
||PD_A17_3| |PD_DEBUG| |   -------------------------
|---------- ---------- |   |VD_PMU      |PD_PMU    |
------------------------   -------------------------
VD_* :  voltage domain
PD_* :  power domain

At the moment, we can support some power-domain type on RK3288.
We can add more types on RK3288 in the future, that's need to do.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v16:
- Add more domain decription.
Series-changes: 15
- change the comment.

 include/dt-bindings/power-domain/rk3288.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/power-domain/rk3288.h

diff --git a/include/dt-bindings/power-domain/rk3288.h b/include/dt-bindings/power-domain/rk3288.h
new file mode 100644
index 0000000..db5e810
--- /dev/null
+++ b/include/dt-bindings/power-domain/rk3288.h
@@ -0,0 +1,31 @@
+#ifndef __DT_BINDINGS_POWER_DOMAIN_RK3288_H__
+#define __DT_BINDINGS_POWER_DOMAIN_RK3288_H__
+
+/**
+ * RK3288 Power Domain and Voltage Domain Summary.
+ */
+
+/* VD_CORE */
+#define RK3288_PD_A17_0		0
+#define RK3288_PD_A17_1		1
+#define RK3288_PD_A17_2		2
+#define RK3288_PD_A17_3		3
+#define RK3288_PD_SCU		4
+#define RK3288_PD_DEBUG		5
+#define RK3288_PD_MEM		6
+
+/* VD_LOGIC */
+#define RK3288_PD_BUS		7
+#define RK3288_PD_PERI		8
+#define RK3288_PD_VIO		9
+#define RK3288_PD_ALIVE		10
+#define RK3288_PD_HEVC		11
+#define RK3288_PD_VIDEO		12
+
+/* VD_GPU */
+#define RK3288_PD_GPU		13
+
+/* VD_PMU */
+#define RK3288_PD_PMU		14
+
+#endif
-- 
1.9.1
