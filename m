From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:23:58 -0500
Subject: [RFC 02/55] KVM: arm64: Add nesting config option
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-3-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Add an option that allows nested hypervisor support.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/kvm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 6eaf12c..37263ff 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -57,6 +57,12 @@ config KVM_ARM_PMU
 	  Adds support for a virtual Performance Monitoring Unit (PMU) in
 	  virtual machines.
 
+config KVM_ARM_NESTED_HYP
+	bool "Nested Virtualization"
+	depends on KVM
+	---help---
+	  Support nested hypervisors in VMs.
+
 source drivers/vhost/Kconfig
 
 endif # VIRTUALIZATION
-- 
1.9.1
