From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Mon, 22 Jan 2018 06:13:27 -0800
Subject: [PATCH v3] net: ethernet: cavium: Correct Cavium Thunderx NIC module
 and driver names
In-Reply-To: <1516290789-3585-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
References: <1516290789-3585-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <1516630407-23161-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

It was found that ethtool provides unexisting module name while
it queries the specified network device for associated driver
information. Then user tries to unload that module by provided
module name and fails.

This happens because ethtool reads value of DRV_NAME macro,
while module name is defined at the driver's Makefile.

This patch is to correct Cavium CN88xx Thunder NIC driver modules
names 'nicvf' to 'thunder_nicvf' and 'nicpf' to 'thunder_nicpf' along
with updating DRV_NAME macro values accordingly.

Signed-off-by: Dean Nelson <dnelson@redhat.com>
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/Makefile        | 10 +++++-----
 drivers/net/ethernet/cavium/thunder/nic_main.c      |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c |  2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c    |  2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c   |  2 +-
 drivers/net/ethernet/cavium/thunder/thunder_xcv.c   |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/Makefile b/drivers/net/ethernet/cavium/thunder/Makefile
index 6b4d4add7353..f5642337d0fe 100644
--- a/drivers/net/ethernet/cavium/thunder/Makefile
+++ b/drivers/net/ethernet/cavium/thunder/Makefile
@@ -4,9 +4,9 @@
 
 obj-$(CONFIG_THUNDER_NIC_RGX) += thunder_xcv.o
 obj-$(CONFIG_THUNDER_NIC_BGX) += thunder_bgx.o
-obj-$(CONFIG_THUNDER_NIC_PF) += nicpf.o
-obj-$(CONFIG_THUNDER_NIC_VF) += nicvf.o
+obj-$(CONFIG_THUNDER_NIC_PF) += thunder_nicpf.o
+obj-$(CONFIG_THUNDER_NIC_VF) += thunder_nicvf.o
 
-nicpf-y := nic_main.o
-nicvf-y := nicvf_main.o nicvf_queues.o
-nicvf-y += nicvf_ethtool.o
+thunder_nicpf-y := nic_main.o
+thunder_nicvf-y := nicvf_main.o nicvf_queues.o
+thunder_nicvf-y += nicvf_ethtool.o
diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 8f1dd55b3e08..a8c0d2bde9c8 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -18,7 +18,7 @@
 #include "q_struct.h"
 #include "thunder_bgx.h"
 
-#define DRV_NAME	"thunder-nic"
+#define DRV_NAME	"thunder_nicpf"
 #define DRV_VERSION	"1.0"
 
 struct hw_info {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index b9ece9cbf98b..8a3e3b70afda 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -16,7 +16,7 @@
 #include "q_struct.h"
 #include "thunder_bgx.h"
 
-#define DRV_NAME	"thunder-nicvf"
+#define DRV_NAME	"thunder_nicvf"
 #define DRV_VERSION     "1.0"
 
 struct nicvf_stat {
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 7cb7571f9ad9..de38105fc649 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -26,7 +26,7 @@
 #include "nicvf_queues.h"
 #include "thunder_bgx.h"
 
-#define DRV_NAME	"thunder-nicvf"
+#define DRV_NAME	"thunder_nicvf"
 #define DRV_VERSION	"1.0"
 
 /* Supported devices */
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 5e5c4d7796b8..79fae7de3404 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -21,7 +21,7 @@
 #include "nic.h"
 #include "thunder_bgx.h"
 
-#define DRV_NAME	"thunder-BGX"
+#define DRV_NAME	"thunder_bgx"
 #define DRV_VERSION	"1.0"
 
 struct lmac {
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
index 578c7f8f11bf..2d5e8dab1f70 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_xcv.c
@@ -20,7 +20,7 @@
 #include "nic.h"
 #include "thunder_bgx.h"
 
-#define DRV_NAME	"thunder-xcv"
+#define DRV_NAME	"thunder_xcv"
 #define DRV_VERSION	"1.0"
 
 /* Register offsets */
-- 
2.14.3
