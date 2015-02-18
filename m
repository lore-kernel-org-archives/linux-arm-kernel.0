From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Wed, 18 Feb 2015 14:57:21 +0200
Subject: [PATCH 1/2] devicetree: Document generic watchdog properties
In-Reply-To: <cover.1424262664.git.timo.kokkonen@offcode.fi>
References: <54B53160.6060309@roeck-us.net>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
Message-ID: <ede7fa9a2116ad8df2dca184d70fb16d1245d6a3.1424262664.git.timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no documentation for the watchdog properties that are common
among most of the watchdog drivers. Add document where these generic
properties can be described and told how they should be used in
drivers. Start from the "timeout-sec" property.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 Documentation/devicetree/bindings/watchdog/watchdog.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.txt b/Documentation/devicetree/bindings/watchdog/watchdog.txt
new file mode 100644
index 0000000..7e3686c
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.txt
@@ -0,0 +1,12 @@
+These properties are common among most watchdog drivers. Any driver
+that requires the functionality listed below should implement them
+using these definitions.
+
+Optional properties:
+- timeout-sec: Contains the watchdog timeout in seconds.
+
+Example:
+
+watchdog {
+	 timeout-sec = <60>;
+};
-- 
2.1.0
