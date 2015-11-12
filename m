From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 12 Nov 2015 17:30:45 +0000
Subject: [PATCH v4 4/7] arm: extend pvclock_wall_clock with sec_hi
In-Reply-To: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
Message-ID: <1447349448-22610-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hypervisor actually exposes an additional field to struct
pvclock_wall_clock, with the high 32 bit seconds.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/include/asm/xen/interface.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/xen/interface.h b/arch/arm/include/asm/xen/interface.h
index 5006600..5b150d7 100644
--- a/arch/arm/include/asm/xen/interface.h
+++ b/arch/arm/include/asm/xen/interface.h
@@ -76,6 +76,7 @@ struct pvclock_wall_clock {
 	u32   version;
 	u32   sec;
 	u32   nsec;
+	u32   sec_hi;
 } __attribute__((__packed__));
 #endif
 
-- 
1.7.10.4
