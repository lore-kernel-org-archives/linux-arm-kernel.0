From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 19 Oct 2015 17:34:48 +0200
Subject: [PATCH 11/20] sound,
 skylake: switch from ioremap_cache to memremap
In-Reply-To: <20151019152641.GC32054@sirena.org.uk>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
 <20151019152641.GC32054@sirena.org.uk>
Message-ID: <s5hk2qi3m93.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Oct 2015 17:26:41 +0200,
Mark Brown wrote:
> 
> On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
> > In preparation for deprecating ioremap_cache() convert its usage in
> > skl-nhlt to memremap.
> 
> > -void __iomem *skl_nhlt_init(struct device *dev)
> > +void *skl_nhlt_init(struct device *dev)
> 
> Why are we loosing the annotation here?

It's the exact purpose of this patchset, as far as I understand.
memremap() allows the driver accessing the mapped memory just like a
normal memory unlike ioremap().


Takashi
