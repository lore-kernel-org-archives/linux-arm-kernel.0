From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Feb 2014 19:43:21 +0100
Subject: [PATCH v2 05/23] ARM: Kirkwood: Seperate board-dt from common and
 pcie code.
In-Reply-To: <20140218183746.GH29304@obsidianresearch.com>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140215140505.GB26088@lunn.ch>
 <20140218183746.GH29304@obsidianresearch.com>
Message-ID: <2739928.UWFnYz3xQ3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014 11:37:46 Jason Gunthorpe wrote:
> 
> No idea of the history, but for DMA heavy work loads write-through is
> better since you spend less cpu cycles doing cache flushing, while for
> CPU centric work loads write-back is better since you spend less time
> waiting for memory.
> 
> Since these SOCs are popular for storage and networking apps I'm not
> surprised to see this option.

Ok, that makes much more sense than anything I could come up with ;-)

> But a static config option is not really in-line with current thinking
> on these sorts of things. A DT option would be better (IMHO), but even
> that is probably not going to be universally loved.

One of the later patches actually introduced a DT property for
it, but the implementation of that seemed incomplete, so the current
plan is to keep the Kconfig option for now.

> Can we worry about this after Andrew's shuffling is done?

Sure.

	Arnd
