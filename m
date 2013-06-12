From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Jun 2013 00:20:30 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612220250.GA14852@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306122352.32749.arnd@arndb.de>
 <20130612220250.GA14852@obsidianresearch.com>
Message-ID: <201306130020.30437.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2013 at 11:52:32PM +0200, Arnd Bergmann wrote:
> > Whether that results in an optimum mapping or not depends on the actual
> > sizes for the child nodes. Since everything is a power-of-two size,
> > a first-fit algorithm actually isn't bad at all.
> 
> The windows must be aligned to their size. eg 1M size window must be
> aligned to a 1M boundary.
> 
> First fit only works if you allocate from largest alignment
> requirement to smallest, otherwise the worst case is something like
> nearly double the largest alignment wasted in alignment padding.

Yes, I realize that, which is why I said it depends on the actual sizes.
If you have a lot of windows that are all the same size and nothing larger,
the worst case isn't too bad.

	Arnd
