From: nicolas.cavallari@green-communications.fr (Nicolas Cavallari)
Date: Thu,  4 Oct 2018 18:23:39 +0200
Subject: [RFC UGLY 2/2] arm: Re-enable interrupts after shutting down non-boot
 CPUs.
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
Message-ID: <20181004162339.19493-3-nicolas.cavallari@green-communications.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some system power controller are behind bus like i2c, whose
controller driver requires interrupts to work.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 arch/arm/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3b2aa9a9fe26..2773068c0d67 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -140,6 +140,7 @@ void machine_restart(char *cmd)
 {
 	local_irq_disable();
 	smp_send_stop();
+	local_irq_enable();
 
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
-- 
2.19.0
