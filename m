From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Apr 2012 10:55:48 +0100
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1333619748-16126-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides full documentation detailing each compulsory,
optional and device (variant) specific properties available
for use within the MMCI Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
new file mode 100644
index 0000000..16502a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -0,0 +1,19 @@
+* ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
+
+The ARM PrimeCell MMCI PL180 and PL181 provides and interface for
+reading and writing to MultiMedia and SD cards alike.
+
+Required properties:
+- compatible             : contains "arm,pl18x", "arm,primecell".
+- reg                    : contains pl18x registers and length.
+- interrupts             : contains the device IRQ(s).
+- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
+
+Optional properties:
+- wp-gpios               : contains any write protect (ro) gpios
+- cd-gpios               : contains any card detection gpios
+- cd-inverted            : indicates whether the cd gpio is inverted
+- clock-frequency        : contains the maximum operating frequency
+- bus-width              : Number of data lines, can be <1>, <4>, or <8>
+- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
+- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
-- 
1.7.9.1
