From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Thu, 18 Jan 2018 07:42:40 -0800
Subject: [PATCH] net: ethernet: cavium: Correct Cacivum Thunderx nicvf/nicpf
 modules names
Message-ID: <1516290160-3396-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

It was found that ethtool provides unexisting module name while
it queries the specified network device for associated driver
information.

This patch is to correct Cavium CN88xx Thunder nicvf/nicpf modules
names 'nicvf' to 'thunder_nicvf' and 'nicpf' to 'thunder_nicpf'.

Signed-off-by: Dean Nelson <dnelson@redhat.com>
Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.14.3
