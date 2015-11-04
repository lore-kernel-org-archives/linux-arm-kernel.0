From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  4 Nov 2015 15:49:48 +0100
Subject: [PULL 09/21] arm/arm64: KVM : Enable vhost device selection under KVM
 config menu
In-Reply-To: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
References: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1446648600-27297-10-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Huang <wei@redhat.com>

vhost drivers provide guest VMs with better I/O performance and lower
CPU utilization. This patch allows users to select vhost devices under
KVM configuration menu on ARM. This makes vhost support on arm/arm64
on a par with other architectures (e.g. x86, ppc).

Signed-off-by: Wei Huang <wei@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/Kconfig   | 2 ++
 arch/arm64/kvm/Kconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 356970f..95a0005 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -46,4 +46,6 @@ config KVM_ARM_HOST
 	---help---
 	  Provides host support for ARM processors.
 
+source drivers/vhost/Kconfig
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 5c7e920..38102f5 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -41,4 +41,6 @@ config KVM_ARM_HOST
 	---help---
 	  Provides host support for ARM processors.
 
+source drivers/vhost/Kconfig
+
 endif # VIRTUALIZATION
-- 
2.1.2.330.g565301e.dirty
