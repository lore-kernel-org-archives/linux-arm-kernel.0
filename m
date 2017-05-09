From: cdall@linaro.org (Christoffer Dall)
Date: Tue,  9 May 2017 12:44:33 +0200
Subject: [PULL 04/37] KVM: arm/arm64: Add GICV3 pending table save API
 documentation
In-Reply-To: <20170509104506.30929-1-cdall@linaro.org>
References: <20170509104506.30929-1-cdall@linaro.org>
Message-ID: <20170509104506.30929-5-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Auger <eric.auger@redhat.com>

Add description for how to save GICV3 LPI pending bit into
guest RAM pending tables.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
index c1a2461..9293b45 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
@@ -167,11 +167,17 @@ Groups:
     KVM_DEV_ARM_VGIC_CTRL_INIT
       request the initialization of the VGIC, no additional parameter in
       kvm_device_attr.addr.
+    KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
+      save all LPI pending bits into guest RAM pending tables.
+
+      The first kB of the pending table is not altered by this operation.
   Errors:
     -ENXIO: VGIC not properly configured as required prior to calling
      this attribute
     -ENODEV: no online VCPU
     -ENOMEM: memory shortage when allocating vgic internal data
+    -EFAULT: Invalid guest ram access
+    -EBUSY:  One or more VCPUS are running
 
 
   KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO
-- 
2.9.0
