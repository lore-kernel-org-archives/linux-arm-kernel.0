From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Apr 2012 16:20:19 +0100
Subject: [PATCH 7/7 v2] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
Message-ID: <4F8EDBB3.7070506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 14 Mar 2012 13:58:34 +0000
Subject: [PATCH] MMC: mmci: Add required documentation for Device Tree bindings

This provides full documentation detailing each compulsory,
optional and device (variant) specific properties available
for use within the MMCI Device Tree.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
new file mode 100644
index 0000000..5b68c93
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
+
+Optional properties:
+- wp-gpios               : contains any write protect (ro) gpios
+- cd-gpios               : contains any card detection gpios
+- cd-inverted            : indicates whether the cd gpio is inverted
+- max-frequency          : contains the maximum operating frequency
+- bus-width              : number of data lines, can be <1>, <4>, or <8>
+- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
+- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
+- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
-- 
1.7.9.1
