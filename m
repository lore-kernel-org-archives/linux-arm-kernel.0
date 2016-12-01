From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Thu,  1 Dec 2016 12:39:47 +0530
Subject: [PATCH v10 8/8] arm/arm64: Documentation: Update arm-vgic-v3.txt
In-Reply-To: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1480576187-5012-9-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Update error code returned for Invalid CPU interface register
value and access in AArch32 mode.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
---
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index 9348b3c..0f29850 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -142,10 +142,12 @@ Groups:
     KVM_DEV_ARM_VGIC_CPU_SYSREGS accesses the CPU interface registers for the
     CPU specified by the mpidr field.
 
+    CPU interface registers access is not implemented for AArch32 mode.
+    Error -ENXIO is returned when accessed in AArch32 mode.
   Errors:
     -ENXIO: Getting or setting this register is not yet supported
     -EBUSY: VCPU is running
-    -EINVAL: Invalid mpidr supplied
+    -EINVAL: Invalid mpidr or register value supplied
 
 
   KVM_DEV_ARM_VGIC_GRP_NR_IRQS
@@ -193,6 +195,11 @@ Groups:
 
 	Bit[n] indicates the status for interrupt vINTID + n.
 
+	Getting or setting the level info for an edge-triggered interrupt is
+	not guaranteed to work.  To restore the complete state of the VGIC, the
+	configuration (edge/level) of interrupts must be restored before
+	restoring the level.
+
     SGIs and any interrupt with a higher ID than the number of interrupts
     supported, will be RAZ/WI.  LPIs are always edge-triggered and are
     therefore not supported by this interface.
-- 
1.9.1
