From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 16:26:41 +0100
Subject: [PATCH 11/20] sound, skylake: switch from ioremap_cache to
 memremap
In-Reply-To: <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <20151019152641.GC32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> skl-nhlt to memremap.

> -void __iomem *skl_nhlt_init(struct device *dev)
> +void *skl_nhlt_init(struct device *dev)

Why are we loosing the annotation here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/84ef4802/attachment.sig>
