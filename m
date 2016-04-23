From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Sat, 23 Apr 2016 17:05:16 +0800
Subject: [PATCH v2 net-next 12/13] Documentation: Bindings: add port-idx-in-ae
 for enet node
In-Reply-To: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461402317-136499-13-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds description for port-idx-in-ae attribute.

Signed-off-by: Yisen Zhuang <yisen.zhuang@huawei.com>
---
 .../devicetree/bindings/net/hisilicon-hns-nic.txt  | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
index e6a9d1c..b9ff4ba 100644
--- a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
+++ b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
@@ -36,6 +36,34 @@ Required properties:
                        | | | | | |
                       external port
 
+  This attribute is remained for compatible purpose. It is not recommended to
+  use it in new code.
+
+- port-idx-in-ae: is the index of port provided by AE.
+  In NIC mode of DSAF, all 6 PHYs of service DSAF are taken as ethernet ports
+  to the CPU. The port-idx-in-ae can be 0 to 5. Here is the diagram:
+            +-----+---------------+
+            |            CPU      |
+            +-+-+-+---+-+-+-+-+-+-+
+              |    |   | | | | | |
+           debug debug   service
+           port  port     port
+           (0)   (0)     (0-5)
+
+  In Switch mode of DSAF, all 6 PHYs of service DSAF are taken as physical
+  ports connected to a LAN Switch while the CPU side assume itself have one
+  single NIC connected to this switch. In this case, the port-idx-in-ae
+  will be 0 only.
+            +-----+-----+------+------+
+            |                CPU      |
+            +-+-+-+-+-+-+-+-+-+-+-+-+-+
+              |    |     service| port(0)
+            debug debug  +------------+
+            port  port   |   switch   |
+            (0)   (0)    +-+-+-+-+-+-++
+                          | | | | | |
+                         external port
+
 - local-mac-address: mac addr of the ethernet interface
 
 Example:
@@ -43,6 +71,6 @@ Example:
 	ethernet at 0{
 		compatible = "hisilicon,hns-nic-v1";
 		ae-handle = <&dsaf0>;
-		port-id = <0>;
+		port-idx-in-ae = <0>;
 		local-mac-address = [a2 14 e4 4b 56 76];
 	};
-- 
1.9.1
