From: gores@marvell.com (Siddarth Gore)
Date: Thu, 20 May 2010 15:47:56 +0530
Subject: L2 cache support for pxa16x
In-Reply-To: <AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
Message-ID: <1274350676.6926.58.camel@pe-dt434>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 03:11 -0700, Eric Miao wrote:
> On Wed, May 12, 2010 at 11:56 AM, Siddarth Gore <gores@marvell.com> wrote:
> > Hi Eric/Haojian,
> >
> > Can the Tauros2 support be used for pxa168 as well? The one difference I
> > can see is that L2 Enable is in control register instead of extra
> > feature register. But rest of the things look very similar to me.
> >

I tried doing this. It works when I enable L2 before turning the MMU on,
i.e. in __mohawk_setup

But when I do the following in tauros2_init(), the kernel crashes.
1. flush and disable dcache
2. invalidate and disable icache
3. drain write buffer
4. invalidate TLB
5. invalidate L2
6. enable L2
7. enable icache
8. enable dcache

I think the right place to enable L2 is in tauros2_init, so any idea
what I am doing wrong here?

-siddarth
