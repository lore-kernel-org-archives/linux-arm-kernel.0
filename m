From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:46:06 +0100
Subject: [PATCH 31/31] KVM: arm64: vgic-v3: Log which GICv3 system registers
 are trapped
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-32-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to facilitate debug, let's log which class of GICv3 system
registers are trapped.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 717219ab58a2..9110657b502c 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -407,7 +407,10 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 #endif
 
 	if (group0_trap || group1_trap || common_trap) {
-		kvm_info("GICv3 sysreg trapping enabled (reduced performance)\n");
+		kvm_info("GICv3 sysreg trapping enabled ([%s%s%s], reduced performance)\n",
+			 group0_trap ? "G0" : "",
+			 group1_trap ? "G1" : "",
+			 common_trap ? "C"  : "");
 		static_branch_enable(&vgic_v3_cpuif_trap);
 	}
 
-- 
2.11.0
