From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Wed, 15 Mar 2017 11:55:20 +0100
Subject: [PATCH v4 01/18] dt-bindings: power: battery: add
 constant-charge-current property
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Message-ID: <20170315105537.22349-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the constant-charge-current property to the list of optional
properties of the battery.

The constant charge current is critical for batteries as they can't
handle all charge currents.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---

v4:
 - switch from constant-charge-current-microamp to constant-charge-microamp,

added in v3

 Documentation/devicetree/bindings/power/supply/battery.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 0278617..9594e1e 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -7,6 +7,7 @@ Optional Properties:
  - voltage-min-design-microvolt: drained battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - constant-charge-microamp: battery constant charge current
 
 Because drivers surface properties in sysfs using names derived
 from enum power_supply_property, e.g.
@@ -30,6 +31,7 @@ Example:
 		voltage-min-design-microvolt = <3200000>;
 		energy-full-design-microwatt-hours = <5290000>;
 		charge-full-design-microamp-hours = <1430000>;
+		constant-charge-microamp = <300000>;
 	};
 
 	charger: charger at 11 {
-- 
2.9.3
