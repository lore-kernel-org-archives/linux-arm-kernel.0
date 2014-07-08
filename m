From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 8 Jul 2014 17:16:50 +0100
Subject: [PATCH v2 1/3] xen/arm: introduce XENFEAT_grant_map_11
In-Reply-To: <1404834132-15847-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>
 <1404834132-15847-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <53BC1972.9050907@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/14 16:42, Stefano Stabellini wrote:
> The flag tells us that the hypervisor maps a grant page to guest
> physical address == machine address of the page in addition to the
> normal grant mapping address. It is needed to properly issue cache
> maintenance operation at the completion of a DMA operation involving a
> foreign grant.
[...]
> +/* Xen also maps grant references at pfn = mfn */
> +#define XENFEAT_grant_map_11              12

I keep reading this as "grant map eleven".  I think you've used this
abbreviation else where so you should probably keep it as-is.

I might have picked XENFEAT_grant_map_identity.

David
