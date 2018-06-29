From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 29 Jun 2018 13:04:30 +0200
Subject: [PATCH 1/3] PM / Domains: dt: Add a power-domain-names property
In-Reply-To: <20180629110432.5179-1-ulf.hansson@linaro.org>
References: <20180629110432.5179-1-ulf.hansson@linaro.org>
Message-ID: <20180629110432.5179-2-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's add a power-domain-names property, to allow consumer drivers to match
the power-domains specifiers via a list of power domain names. This follows
the same concept as for other similar DT bindings.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/power/power_domain.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
index 9b387f861aed..4d6bc8829468 100644
--- a/Documentation/devicetree/bindings/power/power_domain.txt
+++ b/Documentation/devicetree/bindings/power/power_domain.txt
@@ -114,18 +114,26 @@ Required properties:
  - power-domains : A list of PM domain specifiers, as defined by bindings of
 		the power controller that is the PM domain provider.
 
+Optional properties:
+ - power-domain-names : A list of power domain name strings sorted in the same
+		order as the power-domains property. Consumers drivers will use
+		power-domain-names to match power domains with power-domains
+		specifiers.
+
 Example:
 
 	leaky-device at 12350000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12350000 0x1000>;
 		power-domains = <&power 0>;
+		power-domain-names = "io";
 	};
 
 	leaky-device at 12351000 {
 		compatible = "foo,i-leak-current";
 		reg = <0x12351000 0x1000>;
 		power-domains = <&power 0>, <&power 1> ;
+		power-domain-names = "io", "clk";
 	};
 
 The first example above defines a typical PM domain consumer device, which is
-- 
2.17.1
