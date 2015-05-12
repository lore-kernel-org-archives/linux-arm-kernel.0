From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 18:03:34 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <20150512175431.378c346e@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <4862159.g8Sk9nOiS2@wuerfel> <20150512175431.378c346e@free-electrons.com>
Message-ID: <3020836.4xH6fTICuR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 May 2015 17:54:31 Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 12 May 2015 17:49:08 +0200, Arnd Bergmann wrote:
> 
> > Using 
> > 
> >       if (IS_ENABLED(__BIG_ENDIAN))
> > 
> > here would make it more readable by avoiding the #if. Alternatively,
> > you could leave the XOR_DESCRIPTOR_SWAP flag disabled and just swap
> > the descriptors manually like a lot of other drivers do. You have
> > to swap the mmio accesses anywya.
> 
> Agreed on IS_ENABLED(). However, I don't understand the comment about
> the need to swap mmio accesses? We're using readl_relaxed() /
> writel_relaxed(), and they do the swapping already. Am I missing
> something?
> 

Sorry for being unclear. This was exactly my point: readl_relaxed()
has to do swaps internally, and you can also do swaps when accessing
the descriptor in memory.

	Arnd
