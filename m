From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  8 May 2015 10:18:03 +0900
Subject: [v4 3/4] arm64: kvm: remove !KEXEC dependency
In-Reply-To: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1431047884-5637-4-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By indroducing cpu kvm hotplug, this dependency is not needed any more.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kvm/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 30ae7a7..f5590c8 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -18,7 +18,6 @@ if VIRTUALIZATION
 
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
-	depends on !KEXEC
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-- 
1.7.9.5
