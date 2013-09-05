From: anup.patel@linaro.org (Anup Patel)
Date: Thu,  5 Sep 2013 20:16:02 +0530
Subject: =?UTF-8?q?=5BRFC=20PATCH=203/3=5D=20KVM=3A=20ARM=3A=20Update=20documentation=20for=20KVM=5FARM=5FVCPU=5FINIT=20ioctl?=
In-Reply-To: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1378392362-6773-4-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To implement target type KVM_ARM_TARGET_HOST we make the
KVM_ARM_VCPU_INIT ioctl bi-direction so that KVM ARM/ARM64
can return appropriate target type to user space via
struct kvm_vcpu_init.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 Documentation/virtual/kvm/api.txt |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index ef925ea..c0a3a05 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2283,7 +2283,7 @@ current state.  "addr" is ignored.
 Capability: basic
 Architectures: arm, arm64
 Type: vcpu ioctl
-Parameters: struct struct kvm_vcpu_init (in)
+Parameters: struct kvm_vcpu_init (in/out)
 Returns: 0 on success; -1 on error
 Errors:
  ?EINVAL: ???the target is unknown, or the combination of features is invalid.
@@ -2303,6 +2303,9 @@ Possible features:
 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
 
+This ioctl returns updated struct kvm_vcpu_init showing VCPU target 
+type and VCPU features that will be available.
+
 
 4.83 KVM_GET_REG_LIST
 
-- 
1.7.9.5
