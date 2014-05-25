From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:18:50 +0200
Subject: [PATCH 04/16] KVM: Documentation: Add info regarding
 KVM_ARM_VCPU_PSCI_0_2 feature
In-Reply-To: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1401041942-23471-5-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

We have in-kernel emulation of PSCI v0.2 in KVM ARM/ARM64. To provide
PSCI v0.2 interface to VCPUs, we have to enable KVM_ARM_VCPU_PSCI_0_2
feature when doing KVM_ARM_VCPU_INIT ioctl.

The patch updates documentation of KVM_ARM_VCPU_INIT ioctl to provide
info regarding KVM_ARM_VCPU_PSCI_0_2 feature.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 2014ff1..556d056 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2376,6 +2376,8 @@ Possible features:
 	  Depends on KVM_CAP_ARM_PSCI.
 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
+	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 for the CPU.
+	  Depends on KVM_CAP_ARM_PSCI_0_2.
 
 
 4.83 KVM_ARM_PREFERRED_TARGET
-- 
1.8.5.2
