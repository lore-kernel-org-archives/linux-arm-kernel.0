From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Aug 2013 22:20:54 +0100
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <2011590.EGDykoeEOS@amdc1227>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <52134B92.10308@samsung.com> <52139AE7.4050300@wwwdotorg.org>
 <2011590.EGDykoeEOS@amdc1227>
Message-ID: <20130829212054.568123E1222@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Aug 2013 17:39:48 +0200, Tomasz Figa <t.figa@samsung.com> wrote:
> On Tuesday 20 of August 2013 10:35:51 Stephen Warren wrote:
> > >> a) Adjust memory.txt to allow multiple entries in memory-regions, and
> > >> add an associated memory-region-names property.
> > >> 
> > I don't believe that's a good approach unless you have at least a
> > partial idea of how the current bindings will be extended to support
> > multiple memory regions.
> 
> I believe that at least three "at least partial" ideas have been brought in 
> this thread. Moreover, I don't think that defining the simple binding now 
> would stop us from extending it according to any of those ideas in any way.

I would plan on extending later with suggestion 'a)' above. Making the
memory-region an array of phandles is a better match with how most of
the core bindings work.  I actually regret the *-gpio properties that
were defined earlier becasue it makes it harder for software to look at
a tree and determine if there are any gpio references.

It of course doesn't need to be done immediately, only when it becomes
required.

g.
