From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon,  6 Jun 2016 16:36:06 +0100
Subject: [PATCH 3/3] firmware: arm_scpi: make it depend on MAILBOX instead of
 ARM_MHU
In-Reply-To: <1465227366-12192-1-git-send-email-sudeep.holla@arm.com>
References: <1465227366-12192-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1465227366-12192-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM_SCPI_PROTOCOL can be used with any mailbox and not just ARM MHU
mailbox controller. This patch drops it's dependency on ARM_MHU and
make it depend on just mailbox framework.

Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6664f1108c7c..41abdc54815e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -10,7 +10,7 @@ config ARM_PSCI_FW

 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
-	depends on ARM_MHU
+	depends on MAILBOX
 	help
 	  System Control and Power Interface (SCPI) Message Protocol is
 	  defined for the purpose of communication between the Application
--
2.7.4
