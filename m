From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Aug 2012 13:34:51 +0100
Subject: [PATCHv6 2/2] ARM: dma-mapping: remove custom consistent dma
 region
In-Reply-To: <20120821142235.97984abc9ad98d01015a3338@nvidia.com>
References: <1343636899-19508-1-git-send-email-m.szyprowski@samsung.com>
 <1343636899-19508-3-git-send-email-m.szyprowski@samsung.com>
 <20120821142235.97984abc9ad98d01015a3338@nvidia.com>
Message-ID: <20120821123451.GV18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 02:22:35PM +0300, Hiroshi Doyu wrote:
> The following "__get_vm_area_node()" can take gfp_mask, it means that
> this function is expected to be called from atomic context, but why
> it's _NOT_ allowed _ONLY_ from interrupt context?

One reason is it takes read/write locks without using the IRQ safe
versions for starters (vmap_area_lock and vmlist_lock).  I don't see
any other reasons in that bit of code though.
