From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 5 Jun 2017 10:17:29 -0700 (PDT)
Subject: [PATCH 2/3] arm/xen: Delete an error message for a failed memory
 allocation in __set_phys_to_machine_multi()
In-Reply-To: <004250a0-d94b-7587-ae5d-524ba2911a16@users.sourceforge.net>
References: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
 <004250a0-d94b-7587-ae5d-524ba2911a16@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1706051016590.2941@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Jun 2017, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 4 Jun 2017 21:12:36 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/xen/p2m.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
> index 11e78432b663..f5f74ac637b9 100644
> --- a/arch/arm/xen/p2m.c
> +++ b/arch/arm/xen/p2m.c
> @@ -148,7 +148,6 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
> -	if (!p2m_entry) {
> -		pr_warn("cannot allocate xen_p2m_entry\n");
> +	if (!p2m_entry)
>  		return false;
> -	}
> +
>  	p2m_entry->pfn = pfn;
>  	p2m_entry->nr_pages = nr_pages;
>  	p2m_entry->mfn = mfn;
> -- 
> 2.13.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
