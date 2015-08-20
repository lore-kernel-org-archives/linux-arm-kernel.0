From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 10:49:43 +0100
Subject: [Xen-devel] [PATCH v3 03/20] xen: Add Xen specific page definition
In-Reply-To: <1438966019-19322-4-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-4-git-send-email-julien.grall@citrix.com>
Message-ID: <55D5A2B7.5000106@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 17:46, Julien Grall wrote:
> The Xen hypercall interface is always using 4K page granularity on ARM
> and x86 architecture.
> 
> With the incoming support of 64K page granularity for ARM64 guest, it
> won't be possible to re-use the Linux page definition in Xen drivers.
> 
> Introduce Xen page definition helpers based on the Linux page
> definition. They have exactly the same name but prefixed with
> XEN_/xen_ prefix.
> 
> Also modify xen_page_to_gfn to use new Xen page definition.
[...]
> +#define xen_page_to_pfn(page)	\
> +	(((page_to_pfn(page)) << PAGE_SHIFT) >> XEN_PAGE_SHIFT)

Rename this to page_to_xen_pfn()

David
