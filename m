From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 11:37:10 +0000
Subject: [PATCH 5/7] Documentation: devicetree: fix up pl18x clocks
In-Reply-To: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1392118632-11312-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the pl18x driver expects clocks, and dts provide them, yet the
binding does not mention clocks at all.

This patch adds a description of the clocks, "apb_pclk" (as required by
the primecell binding) and "mclk" for the pl18x itself. The "mclk"
name was chosen to match the official documentation, as currently a
variety of names are used in its place; it is expected that any
operating system supporting these can continue to do so in the absence
of an "mclk" entry.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 2b584ca..1b72d4d 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -9,6 +9,10 @@ by mmc.txt and the properties used by the mmci driver.
 Required properties:
 - compatible             : contains "arm,pl18x", "arm,primecell".
 - arm,primecell-periphid : contains the PrimeCell Peripheral ID.
+- clocks : a list of phandles + clock-specifiers, one for each entry in
+           clock-names.
+- clock-names : should contain "apb_pclk" and "mclk".
+
 
 Optional properties:
 - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
-- 
1.8.1.1
