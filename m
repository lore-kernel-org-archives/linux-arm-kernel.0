From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 7 Aug 2012 14:13:22 -0400
Subject: [PATCH v2 03/23] xen/arm: page.h definitions
In-Reply-To: <1344263246-28036-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
 <1344263246-28036-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120807181322.GG15053@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 03:27:06PM +0100, Stefano Stabellini wrote:
> ARM Xen guests always use paging in hardware, like PV on HVM guests in
> the X86 world.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Ack.. with one nitpick

> +/* XXX: this shouldn't be here */

.. but its here b/c the frontend drivers are using it (its rolled in
headers)- even though we won't hit the code path. So for right now
just punt with this.

> +static inline pte_t *lookup_address(unsigned long address, unsigned int *level)
> +{
> +	BUG();
> +	return NULL;
> +}
> +
> +static inline int m2p_add_override(unsigned long mfn, struct page *page,
> +		struct gnttab_map_grant_ref *kmap_op)
> +{
> +	return 0;
> +}
> +
> +static inline int m2p_remove_override(struct page *page, bool clear_pte)
> +{
> +	return 0;
> +}
> +
> +static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
> +{
> +	BUG();
> +	return false;
> +}
> +#endif /* _ASM_ARM_XEN_PAGE_H */
> -- 
> 1.7.2.5
