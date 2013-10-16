From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 16 Oct 2013 22:32:32 +0530
Subject: [RFC PATCH 3/5] KVM: Add documentation for KVM_EXIT_PSCI exit reason
In-Reply-To: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1381942954-22388-4-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for KVM_EXIT_PSCI exit reason and
PSCI call info in KVM run structure.

We use exit reason KVM_EXIT_PSCI to forward PSCI calls such as
SYSTEM_OFF and SYSTEM_RESET to user space (i.e. QEMU or KVMTOOL)

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 Documentation/virtual/kvm/api.txt |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 076b849..215774d 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2655,6 +2655,19 @@ It gets triggered whenever both KVM_CAP_PPC_EPR are enabled and an
 external interrupt has just been delivered into the guest. User space
 should put the acknowledged interrupt vector into the 'epr' field.
 
+		/* KVM_EXIT_PSCI */
+		struct {
+			__u32 fn;
+			__u64 args[7];
+			__u64 ret[4];
+		} psci;
+
+ARM/ARM64 specific. The KVM ARM/ARM64 emulates Power State and Coordination
+Interface (PSCI) for the Guest. This exit occurs when Guest issues a PSCI
+function call to KVM ARM/ARM64 which is not emulated by in-kernel PSCI
+emulation and needs to be emulated in user space (i.e. QEMU or KVMTOOL).
+Examples of such PSCI functions are SYSTEM_OFF and SYSTEM_RESET.
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
1.7.9.5
