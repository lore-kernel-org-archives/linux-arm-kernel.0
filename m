From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 24 Jul 2015 10:28:32 +0100
Subject: [Xen-devel] [PATCH v2 01/20] xen: Add Xen specific page definition
In-Reply-To: <1436474552-31789-2-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-2-git-send-email-julien.grall@citrix.com>
Message-ID: <55B20540.3020000@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 21:42, Julien Grall wrote:
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
> Also modify page_to_pfn to use new Xen page definition.
>
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> ---
>     I'm wondering if we should drop page_to_pfn has the macro will likely
>     misuse when Linux is using 64KB page granularity.

I think we want xen_gfn_to_page() and xen_page_to_gfn() and Xen
front/back drivers never deal with PFNs only GFNs.

David
