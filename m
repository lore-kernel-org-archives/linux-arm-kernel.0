From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Mar 2013 14:41:10 +0000
Subject: [PATCH v2 1/6] xen/arm: actually pass a non-NULL percpu pointer to
 request_percpu_irq
In-Reply-To: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1303261423530.4430@kaball.uk.xensource.com>
Message-ID: <1364308875-26484-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/enlighten.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 8dc0605..99ce189 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -239,7 +239,7 @@ static int __init xen_init_events(void)
 	xen_init_IRQ();
 
 	if (request_percpu_irq(xen_events_irq, xen_arm_callback,
-			"events", xen_vcpu)) {
+			"events", &xen_vcpu)) {
 		pr_err("Error requesting IRQ %d\n", xen_events_irq);
 		return -EINVAL;
 	}
-- 
1.7.2.5
