From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  5 Mar 2015 14:47:44 +0000
Subject: [PATCH] KVM: vgic: add virt-capable compatible strings
Message-ID: <1425566864-5509-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several dts only list "arm,cortex-a7-gic" or "arm,gic-400" in their GIC
compatible list, and while this is correct (and supported by the GIC
driver), KVM will fail to detect that it can support these cases.

This patch adds the missing strings to the VGIC code. The of_device_id
entries are padded to keep the probe fucntion data aligned.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 virt/kvm/arm/vgic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 0cc6ab6..86cec79 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1865,8 +1865,10 @@ static struct notifier_block vgic_cpu_nb = {
 };
 
 static const struct of_device_id vgic_ids[] = {
-	{ .compatible = "arm,cortex-a15-gic", .data = vgic_v2_probe, },
-	{ .compatible = "arm,gic-v3", .data = vgic_v3_probe, },
+	{ .compatible = "arm,cortex-a15-gic",	.data = vgic_v2_probe, },
+	{ .compatible = "arm,cortex-a7-gic",	.data = vgic_v2_probe, },
+	{ .compatible = "arm,gic-400",		.data = vgic_v2_probe, },
+	{ .compatible = "arm,gic-v3",		.data = vgic_v3_probe, },
 	{},
 };
 
-- 
1.9.1
