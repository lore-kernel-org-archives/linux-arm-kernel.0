From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jun 2014 16:31:22 +0200
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <20140630142224.GA30417@ulmo>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <6153646.CZ57BgYKf3@wuerfel> <20140630142224.GA30417@ulmo>
Message-ID: <4717633.z8gH3C8KXB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 June 2014 16:22:25 Thierry Reding wrote:
> On Mon, Jun 30, 2014 at 03:34:27PM +0200, Arnd Bergmann wrote:
> > On Tuesday 01 July 2014 06:32:10 Kukjin Kim wrote:
> > > This series removes S5P64X0 and S5PC100 related codes in mainline,
> > > because no more user now. And if its supporting is required later,
> > > it will be done with using device tree.
> > > 
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It seems like I'm not completely up-to-date. What happened to our prime
> directive never to remove support for boards? Why is this special? What
> about people that still use this hardware? The commit message says that
> there are no longer any users. How was this determined?

>From what I can tell, the supported machines on these two platforms are
all the official development prototypes, not production boards, and they
came out in rather small quantities, probably Samsung-internal for the
most part. The maintainers have previously assured me they are not aware
of anybody using it, and I trust their judgment.

I'm totally fine with removing support for these machines, and we have
removed a number of similar platforms in the past. The rule is not that
we never remove stuff, the rule is that we never break things for
active users.

As always, if it turns out that we missed some active users, we will
revert these patches, or bring support back another way.

This should probably all be spelled out explicitly in the changelog
for patch 1, which I admit I have not seen.

	Arnd
