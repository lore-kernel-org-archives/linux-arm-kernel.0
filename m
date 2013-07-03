From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Jul 2013 14:04:02 +0200
Subject: [PATCH v5 00/12] MBus DT binding: A new hope
In-Reply-To: <20130702195524.GA14547@obsidianresearch.com>
References: <1372532655-20321-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130702195524.GA14547@obsidianresearch.com>
Message-ID: <201307031404.02930.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 July 2013, Jason Gunthorpe wrote:
> On Sat, Jun 29, 2013 at 04:04:03PM -0300, Ezequiel Garcia wrote:

> > Personally, I can't see any disadvantage, and the binding looks much
> > cleaner now. But of course I can be wrong, and I'm open to discussion.
> > 
> > There's another pending issue. Arnd Bergmann has required to add a
> > property to specify the available space within the CPU address space
> > for decoding windows. This property would allow to support fully
> > dynamic mbus window allocation.
> 
> I wonder if this range is implied - eg it is address space not covered
> by the memory node or any mbus ranges? Is there a situation where that
> is not sufficient?

I think it's sufficient, yes. It feels odd to have the mbus code rely
on the contents of the memory node for that, but it would work.

	Arnd
