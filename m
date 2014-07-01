From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 01 Jul 2014 11:08:35 +0900
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <4717633.z8gH3C8KXB@wuerfel>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <6153646.CZ57BgYKf3@wuerfel> <20140630142224.GA30417@ulmo>
 <4717633.z8gH3C8KXB@wuerfel>
Message-ID: <02c101cf94d1$5d783b30$1868b190$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Monday 30 June 2014 16:22:25 Thierry Reding wrote:
> > On Mon, Jun 30, 2014 at 03:34:27PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 01 July 2014 06:32:10 Kukjin Kim wrote:
> > > > This series removes S5P64X0 and S5PC100 related codes in mainline,
> > > > because no more user now. And if its supporting is required later,
> > > > it will be done with using device tree.
> > > >
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > It seems like I'm not completely up-to-date. What happened to our prime
> > directive never to remove support for boards? Why is this special? What
> > about people that still use this hardware? The commit message says that
> > there are no longer any users. How was this determined?
> 
I asked whether we may remove its supporting in mainline before not just one
time and then no objection at that time...

> From what I can tell, the supported machines on these two platforms are
> all the official development prototypes, not production boards, and they
> came out in rather small quantities, probably Samsung-internal for the
> most part. The maintainers have previously assured me they are not aware
> of anybody using it, and I trust their judgment.
> 
Yeah, I think so ;-)

> I'm totally fine with removing support for these machines, and we have
> removed a number of similar platforms in the past. The rule is not that

S5P6442. I did commit a73ddc61 'ARM: S5P6442: Removing ARCH_S5P6442' in 2011
because that could not be mass-produced.

> we never remove stuff, the rule is that we never break things for
> active users.
> 
YES.

> As always, if it turns out that we missed some active users, we will
> revert these patches, or bring support back another way.
> 
Sure, so please let us know if you have any objection on this removing.

> This should probably all be spelled out explicitly in the changelog
> for patch 1, which I admit I have not seen.
> 
It's my fault, sorry I forgot it and I'm resending 1/17 and 8/17 with -D.

Thanks,
Kukjin
