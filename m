From: anup.patel@linaro.org (Anup Patel)
Date: Thu, 19 Sep 2013 18:41:41 +0530
Subject: =?UTF-8?q?=5BPATCH=20v3=204/4=5D=20KVM=3A=20Add=20documentation=20for=20KVM=5FARM=5FPREFERRED=5FTARGET=20ioctl?=
In-Reply-To: <1379596302-21522-1-git-send-email-anup.patel@linaro.org>
References: <1379596302-21522-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1379596302-21522-5-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To implement CPU=Host we have added KVM_ARM_PREFERRED_TARGET
vm ioctl which provides information to user space required for
creating VCPU matching underlying Host.

This patch adds info related to this new KVM_ARM_PREFERRED_TARGET
vm ioctl in the KVM API documentation.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 Documentation/virtual/kvm/api.txt |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 858aecf..d513cc5 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2303,8 +2303,27 @@ Possible features:
 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
 
+4.83 KVM_ARM_PREFERRED_TARGET
 
-4.83 KVM_GET_REG_LIST
+Capability: basic
+Architectures: arm, arm64
+Type: vm ioctl
+Parameters: struct struct kvm_vcpu_init (out)
+Returns: 0 on success; -1 on error
+Errors:
+ ?ENODEV: ???no preferred target available for the host
+
+This queries KVM for preferred CPU target type which can be emulated
+by KVM on underlying host.
+
+The ioctl returns struct kvm_vcpu_init instance containing information
+about preferred CPU target type and optional features available for it.
+
+The information returned by this ioctl can be used to prepare instance
+of struct kvm_vcpu_init for KVM_ARM_VCPU_INIT ioctl which will result
+in VCPU matching underlying host.
+
+4.84 KVM_GET_REG_LIST
 
 Capability: basic
 Architectures: arm, arm64
@@ -2323,8 +2342,7 @@ struct kvm_reg_list {
 This ioctl returns the guest registers that are supported for the
 KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
 
-
-4.84 KVM_ARM_SET_DEVICE_ADDR
+4.85 KVM_ARM_SET_DEVICE_ADDR
 
 Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
 Architectures: arm, arm64
@@ -2362,7 +2380,7 @@ must be called after calling KVM_CREATE_IRQCHIP, but before calling
 KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
 base addresses will return -EEXIST.
 
-4.85 KVM_PPC_RTAS_DEFINE_TOKEN
+4.86 KVM_PPC_RTAS_DEFINE_TOKEN
 
 Capability: KVM_CAP_PPC_RTAS
 Architectures: ppc
-- 
1.7.9.5
