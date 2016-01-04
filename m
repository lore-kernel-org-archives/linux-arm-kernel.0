From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 23:55:12 +0000
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
Message-ID: <20160104235512.GW16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 03:09:46PM -0800, Andrew Morton wrote:
> On Mon, 4 Jan 2016 22:42:33 +0000 Mark Brown <broonie@kernel.org> wrote:

> > platforms in the kernelci.org boot tests[1].  Doing bisections with
> > Arndale and BeagleBone Black identifies 904769ac82ebf (mm/page_alloc.c:
> > calculate zone_start_pfn at zone_spanned_pages_in_node()) from the akpm
> > tree as the first broken commit[2,3].  An example bootlog from the
> > failure is:

> Thanks.  That patch has rather a blooper if
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=n.  Is that the case in your testing?

Seems to be what's making a difference from a quick run through, yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/05a406fe/attachment.sig>
