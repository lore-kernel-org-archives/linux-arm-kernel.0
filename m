From: prasanna.ps@samsung.com (Prasanna Kumar)
Date: Wed, 09 Jan 2013 18:24:40 +0530
Subject: [PATCH 2/3] ARM:exynos5:dts: Bindings for clock definitions are added.
In-Reply-To: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
References: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <1357736081-19390-3-git-send-email-prasanna.ps@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The details of "samsung,exynos-pd-clks" property is added.

Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 5216b41..dc1e89bd 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -12,6 +12,12 @@ Required Properties:
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
 
+Optional Properties:
+samsung,exynos-pd-clks: After suspend-resume of system ,the clock sources of
+	few devices forming part of power domain need to be saved as they get
+	modified during power domain On->Off operation.Such clock defintions
+	are added via "samsung,exynos-pd-clks" property as strings.
+
 Example:
 
 	lcd0: power-domain-lcd0 {
@@ -26,3 +32,11 @@ Example of the node using power domain:
 		samsung,power-domain = <&lcd0>;
 		/* ... */
 	};
+
+Example of the node using power domain clock defintions:
+
+	node {
+		/* ... */
+		samsung,exynos-pd-clks = "aclk_333";
+		/* ... */
+	};
-- 
1.7.5.4
