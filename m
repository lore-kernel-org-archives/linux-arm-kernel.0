From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Tue, 19 May 2015 11:26:05 +0300
Subject: [PATCHv8 06/10] devicetree: Document generic watchdog properties
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <1432023969-20736-7-git-send-email-timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no documentation for the watchdog properties that are common
among most of the watchdog drivers. Add document where these generic
properties can be described and told how they should be used in
drivers.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 .../devicetree/bindings/watchdog/watchdog.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
new file mode 100644
index 0000000..3781406
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
@@ -0,0 +1,20 @@
+These properties are common among most watchdog drivers. Any driver
+that requires the functionality listed below should implement them
+using these definitions.
+
+Optional properties:
+- timeout-sec: Contains the watchdog timeout in seconds.
+- early-timeout-sec: If present, specify the timeout in seconds for
+  how long it can take for the watchdog daemon to take over the
+  watchdog device. If driver supports this property it must ensure the
+  watchdog hardware is running during this period and a watchdog reset
+  must occur if user space fails to open the device in time. If left
+  zero, the driver only needs to guarantee the watchdog is not
+  stopped or is started during driver init.
+
+Example:
+
+watchdog {
+	 timeout-sec = <60>;
+	 early-timeout-sec = <120>;
+};
-- 
2.1.0
