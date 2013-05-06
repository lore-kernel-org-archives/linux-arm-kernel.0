From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Mon,  6 May 2013 17:49:50 +0530
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write (emerg_wr)
 config register in virtio console.
In-Reply-To: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 Documentation/virtual/virtio-spec.txt |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/virtio-spec.txt b/Documentation/virtual/virtio-spec.txt
index 0d6ec85..3ca38f8 100644
--- a/Documentation/virtual/virtio-spec.txt
+++ b/Documentation/virtual/virtio-spec.txt
@@ -1927,11 +1927,16 @@ Ports 2 onwards only if VIRTIO_CONSOLE_F_MULTIPORT is set
     ports; configuration fields nr_ports and max_nr_ports are
     valid and control virtqueues will be used.
 
+  VIRTIO_CONSOLE_F_EMERG_WRITE(2) Device has support for emergency
+  write. Configuration filed emerg_wr is valid.
+
   Device configuration layout The size of the console is supplied
   in the configuration space if the VIRTIO_CONSOLE_F_SIZE feature
   is set. Furthermore, if the VIRTIO_CONSOLE_F_MULTIPORT feature
   is set, the maximum number of ports supported by the device can
-  be fetched.struct virtio_console_config {
+  be fetched. If VIRTIO_CONSOLE_F_EMERG_WRITE is set then one can
+  use emergency write to output single character without initializing
+  virtio queues. struct virtio_console_config {
 
 	u16 cols;
 
@@ -1941,6 +1946,7 @@ Ports 2 onwards only if VIRTIO_CONSOLE_F_MULTIPORT is set
 
 	u32 max_nr_ports;
 
+	u32 emerg_wr;
 };
 
   Device Initialization
-- 
1.7.9.5
