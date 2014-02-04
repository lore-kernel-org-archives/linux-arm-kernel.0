From: ta.omasab@gmail.com (Thomas Abraham)
Date: Tue,  4 Feb 2014 15:11:30 +0530
Subject: [PATCH 2/2] Documentation: devicetree: Add boost-opp binding to list
 boost mode OPPs
In-Reply-To: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
References: <1391506890-7335-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1391506890-7335-3-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Certain CPUs or devices can support optional boost operating modes. Add a new
binding to list OPPs to be additionally made available in boost operating modes.

Cc: Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 Documentation/devicetree/bindings/power/opp.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
index 74499e5..4df5cca 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -10,6 +10,10 @@ Properties:
 	freq: clock frequency in kHz
 	vol: voltage in microvolt
 
+Optional Properties:
+- boost-opp: Similar to "operating-points" property but usable only in
+  optional boost operating modes.
+
 Examples:
 
 cpu at 0 {
@@ -22,4 +26,9 @@ cpu at 0 {
 		396000  950000
 		198000  850000
 	>;
+	boost-opp = <
+		/* kHz     uV */
+		1500000 1350000
+		1400000 1285000
+	>;
 };
-- 
1.7.10.4
