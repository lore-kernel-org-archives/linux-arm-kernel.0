From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:03:05 +0100
Subject: [GIT PULL 36/36] KVM: Remove unused config symbol
In-Reply-To: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
References: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1422007385-14730-37-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dirty patch logging series introduced both
HAVE_KVM_ARCH_DIRTY_LOG_PROTECT and KVM_GENERIC_DIRTYLOG_READ_PROTECT
config symbols, but only KVM_GENERIC_DIRTYLOG_READ_PROTECT is used.
Just remove the unused one.

(The config symbol was renamed during the development of the patch
series and the old name just creeped in by accident.()

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 314950c..50d1106 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -41,8 +41,5 @@ config KVM_VFIO
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
        bool
 
-config HAVE_KVM_ARCH_DIRTY_LOG_PROTECT
-       bool
-
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
-- 
2.1.2.330.g565301e.dirty
