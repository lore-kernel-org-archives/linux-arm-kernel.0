From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Jun 2013 16:02:50 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <201306122352.32749.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130612212641.GB8625@obsidianresearch.com>
 <20130612213620.GC23012@localhost>
 <201306122352.32749.arnd@arndb.de>
Message-ID: <20130612220250.GA14852@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 11:52:32PM +0200, Arnd Bergmann wrote:
> Whether that results in an optimum mapping or not depends on the actual
> sizes for the child nodes. Since everything is a power-of-two size,
> a first-fit algorithm actually isn't bad at all.

The windows must be aligned to their size. eg 1M size window must be
aligned to a 1M boundary.

First fit only works if you allocate from largest alignment
requirement to smallest, otherwise the worst case is something like
nearly double the largest alignment wasted in alignment padding.

Jason
