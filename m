From: pratyush.anand@st.com (Pratyush Anand)
Date: Thu, 3 Mar 2011 10:46:52 +0530
Subject: [PATCH] ST SPEAr: PCIe Gadget: Documentation for support of multiple
	device
Message-ID: <1299129412-9632-1-git-send-email-pratyush.anand@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Directory naming scheme for multiple PCIe device has been mentioned.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 .../ABI/testing/configfs-spear-pcie-gadget         |    5 +++--
 Documentation/misc-devices/spear-pcie-gadget.txt   |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-spear-pcie-gadget b/Documentation/ABI/testing/configfs-spear-pcie-gadget
index 29593d0..7c02b32 100644
--- a/Documentation/ABI/testing/configfs-spear-pcie-gadget
+++ b/Documentation/ABI/testing/configfs-spear-pcie-gadget
@@ -12,8 +12,9 @@ Description:
 	Nodes are only visible when configfs is mounted. To mount configfs
 	in /config directory use:
 	# mount -t configfs none /config/
-
-	/config/pcie-gadget/
+	
+	For nth PCIe Device Controller
+	/config/pcie-gadget.n/
 		link ... used to enable ltssm and read its status.
 		int_type ...used to configure and read type of supported
 			interrupt
diff --git a/Documentation/misc-devices/spear-pcie-gadget.txt b/Documentation/misc-devices/spear-pcie-gadget.txt
index 7b86b80..02c13ef 100644
--- a/Documentation/misc-devices/spear-pcie-gadget.txt
+++ b/Documentation/misc-devices/spear-pcie-gadget.txt
@@ -66,7 +66,8 @@ Node programming example
 Program all PCIe registers in such a way that when this device is connected
 to the PCIe host, then host sees this device as 1MB RAM.
 #mount -t configfs none /Config
-# cd /config/pcie_gadget/
+For nth PCIe Device Controller
+# cd /config/pcie_gadget.n/
 Now you have all the nodes in this directory.
 program vendor id as 0x104a
 # echo 104A >> vendor_id
-- 
1.6.0.2
