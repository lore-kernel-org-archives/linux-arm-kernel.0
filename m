From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Nov 2014 19:40:58 +0100
Subject: [PATCH 3/5] arm/arm64: KVM: Clarify KVM_ARM_VCPU_INIT ABI
In-Reply-To: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1417113660-23610-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not clear that this ioctl can be called multiple times for a given
vcpu.  Userspace already does this, so clarify the ABI.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 Documentation/virtual/kvm/api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index bb82a90..fc12b4f 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2453,6 +2453,9 @@ return ENOEXEC for that vcpu.
 Note that because some registers reflect machine topology, all vcpus
 should be created before this ioctl is invoked.
 
+Userspace can call this function multiple times for a given VCPU, which will
+reset the VCPU to its initial states.
+
 Possible features:
 	- KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
 	  Depends on KVM_CAP_ARM_PSCI.  If not set, the CPU will be powered on
-- 
2.1.2.330.g565301e.dirty
