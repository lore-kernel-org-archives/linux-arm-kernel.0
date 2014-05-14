From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 06:33:00 +0530
Subject: [PATCH v3 2/2] Documentation: devicetree: Add boost-frequency binding
 to list boost mode frequency
In-Reply-To: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1400029380-5372-3-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add a new optional boost-frequency binding for specifying the frequencies
usable in boost mode.

Cc: Nishanth Menon <nm@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-boost.txt  |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
new file mode 100644
index 0000000..d925e38
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
@@ -0,0 +1,11 @@
+* Device tree binding for CPU boost frequency (aka over-clocking)
+
+Certain CPU's can be operated in optional 'boost' mode (or sometimes referred as
+overclocking) in which the CPU can operate in frequencies beyond the normal
+operating conditions.
+
+Optional Properties:
+- boost-frequency: list of frequencies in KHz to be used only in boost mode.
+  This list should be a subset of frequencies listed in "operating-points"
+  property. Refer to Documentation/devicetree/bindings/power/opp.txt for
+  details about "operating-points" property.
-- 
1.7.4.4
