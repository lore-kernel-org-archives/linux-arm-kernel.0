From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Dec 2016 18:08:14 +0100 (CET)
Subject: Linux crashes when trying to online secondary core
In-Reply-To: <ef972981-3fb6-74a4-cd83-a6629d2dab2a@free.fr>
References: <ef972981-3fb6-74a4-cd83-a6629d2dab2a@free.fr>
Message-ID: <alpine.DEB.2.20.1612141807410.3556@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Dec 2016, Mason wrote:

> Hello,
> 
> I'm seeing Linux v4.9 crash (dereferencing NULL) when I try to online
> the secondary core, after putting it offline.

Does the patch below fix the issue?

Thanks,

	tglx
	
8<---------------

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 22acee76cf4c..2594c287b078 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -101,7 +101,6 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
-	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_JCORE_TIMER_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
@@ -111,6 +110,7 @@ enum cpuhp_state {
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
+	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
