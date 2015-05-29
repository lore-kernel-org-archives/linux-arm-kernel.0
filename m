From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 29 May 2015 14:38:40 +0900
Subject: [PATCH v5 2/2] arm64: kvm: remove !KEXEC dependency
In-Reply-To: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1432877920-12527-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By indroducing kvm cpu hotplug, this dependency is not needed any more.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/kvm/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 13ac79e..5105e29 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -19,7 +19,6 @@ if VIRTUALIZATION
 config KVM
 	bool "Kernel-based Virtual Machine (KVM) support"
 	depends on OF
-	depends on !KEXEC
 	select MMU_NOTIFIER
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-- 
1.7.9.5
