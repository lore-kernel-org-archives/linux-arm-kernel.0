From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 24 Jul 2015 10:49:51 +0100
Subject: [PATCH v2 10/20] xen/xenbus: Use Xen page definition
In-Reply-To: <1436474552-31789-11-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-11-git-send-email-julien.grall@citrix.com>
Message-ID: <55B20A3F.4000408@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 21:42, Julien Grall wrote:
> All the ring (xenstore, and PV rings) are always based on the page
> granularity of Xen.
[...]
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -713,7 +713,7 @@ static int __init xenstored_local_init(void)
>  
>  	xen_store_mfn = xen_start_info->store_mfn =
>  		pfn_to_mfn(virt_to_phys((void *)page) >>
> -			   PAGE_SHIFT);
> +			   XEN_PAGE_SHIFT);

xen_store_pfn = xen_page_to_gfn(page);

Otherwise,

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
