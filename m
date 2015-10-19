From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Oct 2015 17:08:42 +0100
Subject: [PATCH 11/20] sound, skylake: switch from ioremap_cache to
 memremap
In-Reply-To: <s5hk2qi3m93.wl-tiwai@suse.de>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
 <20151019152641.GC32054@sirena.org.uk>
 <s5hk2qi3m93.wl-tiwai@suse.de>
Message-ID: <20151019160842.GF32054@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 05:34:48PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
> > > In preparation for deprecating ioremap_cache() convert its usage in
> > > skl-nhlt to memremap.

> > > -void __iomem *skl_nhlt_init(struct device *dev)
> > > +void *skl_nhlt_init(struct device *dev)

> > Why are we loosing the annotation here?

> It's the exact purpose of this patchset, as far as I understand.
> memremap() allows the driver accessing the mapped memory just like a
> normal memory unlike ioremap().

There's no mention of what the purpose of the conversion is in either
the patch or the cover letter so it's a bit unclear, some confirmation
would be good :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151019/9c29cd3b/attachment-0001.sig>
