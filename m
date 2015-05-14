From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:53 +0100
Subject: [RFC 13/23] xen/xenbus: Use Xen page definition
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-14-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The xenstore ring is always based on the page granularity of Xen.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/xenbus/xenbus_probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5390a67..f99933d9 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -713,7 +713,7 @@ static int __init xenstored_local_init(void)
 
 	xen_store_mfn = xen_start_info->store_mfn =
 		pfn_to_mfn(virt_to_phys((void *)page) >>
-			   PAGE_SHIFT);
+			   XEN_PAGE_SHIFT);
 
 	/* Next allocate a local port which xenstored can bind to */
 	alloc_unbound.dom        = DOMID_SELF;
@@ -804,7 +804,7 @@ static int __init xenbus_init(void)
 			goto out_error;
 		xen_store_mfn = (unsigned long)v;
 		xen_store_interface =
-			xen_remap(xen_store_mfn << PAGE_SHIFT, PAGE_SIZE);
+			xen_remap(xen_store_mfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
-- 
2.1.4
