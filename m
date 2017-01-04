From: eric.auger@redhat.com (Eric Auger)
Date: Wed,  4 Jan 2017 13:32:21 +0000
Subject: [PATCH v5 12/17] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_REMAP value
In-Reply-To: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
References: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483536746-2725-13-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This new enum value aims at indicating whether the irq domain
implements MSI remapping. This property is useful to assess
the IRQ assignment safety at VFIO level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 include/linux/irqdomain.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ffb8460..ab017b2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -183,6 +183,9 @@ enum {
 	/* Irq domain is an IPI domain with single virq */
 	IRQ_DOMAIN_FLAG_IPI_SINGLE	= (1 << 3),
 
+	/* Irq domain is MSI remapping capable */
+	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 4),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
-- 
1.9.1
