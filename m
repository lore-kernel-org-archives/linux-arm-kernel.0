From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Mon, 28 Sep 2015 13:34:38 +0800
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1443418478-8240-3-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, ARM64 is also support EFI startup. We hope use EFI runtime services
to get/set current time and date.

RTC_LIB only controls some configs in drivers/char/Kconfig(included
EFI_RTC), and will be automatically selected when RTC_CLASS opened. So
this patch have no functional change but give an opportunity to select
EFI_RTC when RTC_CLASS closed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..25cec57 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -85,7 +85,7 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
-	select RTC_LIB
+	select RTC_LIB if !EFI
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
--
2.5.0
