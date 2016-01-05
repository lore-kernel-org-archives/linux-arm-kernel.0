From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jan 2016 11:45:49 +0000
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <20160104163528.be56a4b1.akpm@linux-foundation.org>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
 <20160104163528.be56a4b1.akpm@linux-foundation.org>
Message-ID: <20160105114549.GX16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:35:28PM -0800, Andrew Morton wrote:
> On Mon, 4 Jan 2016 23:55:12 +0000 Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jan 04, 2016 at 03:09:46PM -0800, Andrew Morton wrote:

> > > Thanks.  That patch has rather a blooper if
> > > CONFIG_HAVE_MEMBLOCK_NODE_MAP=n.  Is that the case in your testing?

> > Seems to be what's making a difference from a quick run through, yes.

> OK, thanks.

Seems like I was mistaken here somehow or there's some other problem -
I've kicked off another bisect for today's -next:

   https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/137/console

and will follow up with any results.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/73cf50d5/attachment.sig>
