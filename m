From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Mar 2015 14:37:08 +0100
Subject: [PATCH v2 RESEND 1/4] arm/exynos: add asynchronous bridge clock
 bindings
In-Reply-To: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
References: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1426167431-24470-2-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds bindings for clocks required by async-bridges
present in the particular power domain.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Documentation/devicetree/bindings/arm/exynos/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 1e09703..5da38c5 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -22,6 +22,9 @@ Optional Properties:
 	- pclkN, clkN: Pairs of parent of input clock and input clock to the
 		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
 		are supported currently.
+	- asbN: Clocks required by asynchronous bridges (ASB) present in
+		the power domain. These clock should be enabled during power
+		domain on/off operations.
 - power-domains: phandle pointing to the parent power domain, for more details
 		 see Documentation/devicetree/bindings/power/power_domain.txt
 
-- 
1.9.1
