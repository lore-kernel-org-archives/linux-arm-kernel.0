From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jan 2016 19:24:04 +0000
Subject: Widespread boot failures on ARM due to "mm/page_alloc.c:
 calculate zone_start_pfn at zone_spanned_pages_in_node()"
In-Reply-To: <568BB55F.2020709@arm.com>
References: <20160104224233.GU16023@sirena.org.uk>
 <20160104150946.373ed02b8e8b81221340b7c8@linux-foundation.org>
 <20160104235512.GW16023@sirena.org.uk>
 <20160104163528.be56a4b1.akpm@linux-foundation.org>
 <20160105114549.GX16023@sirena.org.uk> <568BB55F.2020709@arm.com>
Message-ID: <20160105192404.GS6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 12:21:51PM +0000, Sudeep Holla wrote:
> On 05/01/16 11:45, Mark Brown wrote:
> >On Mon, Jan 04, 2016 at 04:35:28PM -0800, Andrew Morton wrote:
> >>On Mon, 4 Jan 2016 23:55:12 +0000 Mark Brown <broonie@kernel.org> wrote:
> >>>On Mon, Jan 04, 2016 at 03:09:46PM -0800, Andrew Morton wrote:

> >>>>Thanks.  That patch has rather a blooper if
> >>>>CONFIG_HAVE_MEMBLOCK_NODE_MAP=n.  Is that the case in your testing?

> >>>Seems to be what's making a difference from a quick run through, yes.

> >>OK, thanks.

> >Seems like I was mistaken here somehow or there's some other problem -
> >I've kicked off another bisect for today's -next:

> >    https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/137/console

> >and will follow up with any results.

> With both patches applied(one already in today's -next), I am able to
> boot on ARM64 platform but I get huge load(for each pfn) of below warning:

Bisect on today's -next with Arndale (an ARM platform) flags the same
patch:

  https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/137/console

as does Juno which is an arm64 platform:

  https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/138/console

(it does get to a console but with lots of the backtraces Sudeep
indicated).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160105/66d224f6/attachment.sig>
