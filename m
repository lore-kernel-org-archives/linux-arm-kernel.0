From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:17:41 +0000
Subject: [PATCH v5 4/7] arm: extend pvclock_wall_clock with sec_hi
In-Reply-To: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
Message-ID: <1448029064-22285-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hypervisor actually exposes an additional field to struct
pvclock_wall_clock, with the high 32 bit seconds.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Julien Grall <julien.grall@citrix.com>
---
 arch/arm/include/asm/xen/interface.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 4dfd6d4..75d5968 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -78,6 +78,7 @@ struct pvclock_wall_clock {
 	u32   version;
 	u32   sec;
 	u32   nsec;
+	u32   sec_hi;
 } __attribute__((__packed__));
 #endif
 
-- 
1.7.10.4
