From: eric.auger@redhat.com (Eric Auger)
Date: Thu,  4 May 2017 13:44:22 +0200
Subject: [PATCH v6 02/24] KVM: arm/arm64: Add GICV3 pending table save API
 documentation
In-Reply-To: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
References: <1493898284-29504-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1493898284-29504-3-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add description for how to save GICV3 LPI pending bit into
guest RAM pending tables.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v5: creation
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
2.5.5
