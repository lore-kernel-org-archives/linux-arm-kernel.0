From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 5 Jan 2011 15:28:53 -0800
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <1294268808.2952.18.camel@heimdal.trondhjem.org>
References: <1294254337.16957.13.camel@mulgrave.site>
	<AANLkTi=VZUxNFd7n-qwf5aiOeK5rkk8qBmo+kOpgg7up@mail.gmail.com>
	<1294256169.16957.18.camel@mulgrave.site>
	<20110105200008.GJ8638@n2100.arm.linux.org.uk>
	<1294259637.16957.25.camel@mulgrave.site>
	<AANLkTimzzBsdtWcZtP5E_CH1hUZugGMoaHOiMdQJf764@mail.gmail.com>
	<20110105210448.GM8638@n2100.arm.linux.org.uk>
	<AANLkTi=EXXBTW7oWHq3D+PHsx=thF1CpkRjn0ax2p5rm@mail.gmail.com>
	<1294262208.2952.4.camel@heimdal.trondhjem.org>
	<AANLkTi=3Gu-rz=-OdNtUXn4qw60Df6=YePnzvB=s-+Ov@mail.gmail.com>
	<1294268808.2952.18.camel@heimdal.trondhjem.org>
Message-ID: <AANLkTi=SjMinMp+m726GS1iehj6cQgNy1RqSoUqKhjtv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 3:06 PM, Trond Myklebust
<Trond.Myklebust@netapp.com> wrote:
>
> Yes. The fix I sent out was a call to invalidate_kernel_vmap_range(),
> which takes care of invalidating the cache prior to a virtual address
> read.
>
> My question was specifically about the write through the regular kernel
> mapping: according to Russell and my reading of the cachetlb.txt
> documentation, flush_dcache_page() is only guaranteed to have an effect
> on page cache pages.

I don't think that should ever matter. It's not like the hardware can
know whether it's a dcache page or not.

And if the sw implementation cares, it's doing something really odd.
But who knows - there's a lot of crap out there, and people sometimes
do really odd things to work around the brokenness of a VIVT cache
with aliases.

                       Linus
