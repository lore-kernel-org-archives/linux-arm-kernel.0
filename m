From: anup.patel@linaro.org (Anup Patel)
Date: Mon, 21 Apr 2014 18:29:58 +0530
Subject: [PATCH v10 04/12] KVM: Documentation: Add info regarding
 KVM_ARM_VCPU_PSCI_0_2 feature
In-Reply-To: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
References: <1398085206-30555-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1398085206-30555-5-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have in-kernel emulation of PSCI v0.2 in KVM ARM/ARM64. To provide
PSCI v0.2 interface to VCPUs, we have to enable KVM_ARM_VCPU_PSCI_0_2
feature when doing KVM_ARM_VCPU_INIT ioctl.

The patch updates documentation of KVM_ARM_VCPU_INIT ioctl to provide
info regarding KVM_ARM_VCPU_PSCI_0_2 feature.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/virtual/kvm/api.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a9380ba5..6dc1db5 100644
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
1.7.9.5
