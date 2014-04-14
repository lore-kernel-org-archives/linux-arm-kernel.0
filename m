From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:53:59 +0200
Subject: [PATCH v3 02/11] ARM: mvebu: use CPU_METHOD_OF_DECLARE for SMP on
 Armada XP
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the CPU_METHOD_OF_DECLARE declaration for the Armada
XP SMP operations. Note that the .smp_ops field of Armada XP
DT_MACHINE structure is kept, in order to ensure we remain compatible
with older Device Trees that do not include the "enable-method"
property for the CPUs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 arch/arm/mach-mvebu/platsmp.c                  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index 333f4ae..0dc59c3 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -185,6 +185,7 @@ nodes to be present and contain the properties described below.
 			    "qcom,gcc-msm8660"
 			    "qcom,kpss-acc-v1"
 			    "qcom,kpss-acc-v2"
+			    "marvell,armada-xp-smp"
 
 	- cpu-release-addr
 		Usage: required for systems that have an "enable-method"
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index e98075f..e01ae51 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -138,3 +138,6 @@ struct smp_operations armada_xp_smp_ops __initdata = {
 	.cpu_die		= armada_xp_cpu_die,
 #endif
 };
+
+CPU_METHOD_OF_DECLARE(armada_xp_smp, "marvell,armada-xp-smp",
+		      &armada_xp_smp_ops);
-- 
1.8.3.2
