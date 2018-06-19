From: mhkelley58@gmail.com (Michael Kelley)
Date: Tue, 19 Jun 2018 14:23:15 -0700
Subject: [PATCH 5/5] Drivers: hv: Enable CONFIG_HYPERV on ARM64
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Message-ID: <1529443395-20874-6-git-send-email-mikelley@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on ARM64,
causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f5..c3e11a2 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && PCI && \
+			((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
1.8.3.1
