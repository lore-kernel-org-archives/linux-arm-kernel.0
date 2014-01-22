From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Jan 2014 15:29:15 -0300
Subject: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
In-Reply-To: <20140122181409.GV18269@obsidianresearch.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel> <20140122162136.GA27273@localhost>
 <20140122180100.GE27273@localhost>
 <20140122181409.GV18269@obsidianresearch.com>
Message-ID: <20140122182914.GH27273@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 11:14:09AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 03:01:01PM -0300, Ezequiel Garcia wrote:
> > On Wed, Jan 22, 2014 at 01:21:36PM -0300, Ezequiel Garcia wrote:
> > > > I don't see a good way out that would preserve backwards compatibility,
> > > > other than hardcoding the physical address in the driver, which seems
> > > > just as bad as breaking compatibility. That said, it is always the
> > > > same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> > > > Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
> > > > a fallback would technically work, but we should print a fat warning at
> > > > boot time if we actually fall back to that.
> > > > 
> > > 
> > > Yes, I was thinking just about this. Namely:
> > > 
> > [..]
> > 
> > How about something like this?
> 
> I liked Arnd's idea to use an offset from the first register. With the
> mbus driver we can now actually change the 0xF1.. prefix via the DT.
> 

Good idea. Maybe extracting the base address from the timer control
register: wdt_reg & 0xff000000 ?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
