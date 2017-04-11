From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 11 Apr 2017 23:39:43 +1000
Subject: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
In-Reply-To: <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
Message-ID: <1491917983.7236.9.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> +static inline void __iomem *ioremap_nopost(phys_addr_t offset,
> size_t size)
> +{
> +???????return ioremap_nocache(offset, size);
> +}
> +

No this is wrong as I explained.

This is a semantic that simply *cannot* be generically provided accross
architectures as a mapping attribute.

The solution to your problem lies elsewhere.

Cheers,
Ben.
