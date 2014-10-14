From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 14 Oct 2014 11:12:54 +0200
Subject: [PATCH 1/8] dt: bindings: ux500: Add documentation for PM domains
In-Reply-To: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
References: <1413277981-27451-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1413277981-27451-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 .../devicetree/bindings/arm/ux500/power_domain.txt | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500/power_domain.txt

diff --git a/Documentation/devicetree/bindings/arm/ux500/power_domain.txt b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
new file mode 100644
index 0000000..5679d17
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ux500/power_domain.txt
@@ -0,0 +1,35 @@
+* ST-Ericsson UX500 PM Domains
+
+UX500 supports multiple PM domains which are used to gate power to one or
+more peripherals on the SOC.
+
+The implementation of PM domains for UX500 are based upon the generic PM domain
+and use the corresponding DT bindings.
+
+==PM domain providers==
+
+Required properties:
+ - compatible: Must be "stericsson,ux500-pm-domains".
+ - #power-domain-cells : Number of cells in a power domain specifier, must be 1.
+
+Example:
+	pm_domains: pm_domains0 {
+		compatible = "stericsson,ux500-pm-domains";
+		#power-domain-cells = <1>;
+	};
+
+==PM domain consumers==
+
+Required properties:
+ - power-domains: A phandle and PM domain specifier. Below are the list of
+		valid specifiers:
+
+		Index	Specifier
+		-----	---------
+		0	DOMAIN_VAPE
+
+Example:
+	sdi0_per1 at 80126000 {
+		compatible = "arm,pl18x", "arm,primecell";
+		power-domains = <&pm_domains DOMAIN_VAPE>
+	};
-- 
1.9.1
