From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 18:10:03 -0300
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation
 to the DT binding
In-Reply-To: <20130618205522.GA13691@obsidianresearch.com>
References: <20130618174622.GD2204@obsidianresearch.com>
 <51C0A5F8.8030300@gmail.com> <201306182039.50736.arnd@arndb.de>
 <51C0AA8E.9080807@gmail.com>
 <20130618184753.GA6090@obsidianresearch.com>
 <51C0ADF7.5050609@gmail.com>
 <20130618191018.GB6578@obsidianresearch.com>
 <51C0B4A0.90204@gmail.com> <20130618204911.GB2516@localhost>
 <20130618205522.GA13691@obsidianresearch.com>
Message-ID: <20130618211002.GC2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 02:55:22PM -0600, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 05:49:11PM -0300, Ezequiel Garcia wrote:
> > Hi Sebastian,
> > 
> > You loose +1 internet points for dropping me from Cc ;-)
> > 
> > On Tue, Jun 18, 2013 at 09:27:28PM +0200, Sebastian Hesselbarth wrote:
> > > On 06/18/2013 09:10 PM, Jason Gunthorpe wrote:
> > > >
> > > > The forms could be:
> > > >
> > > >   0IAA0000
> > > >   FK000000
> > > >     - K=0 ->  internal regs
> > > >     - K=1 ->  PCI-E thingy
> > > >      etc
> > > >   1IIAA000 (future expansion example)
> > > 
> > > Ok, got it. Any encoding is fine that allows to distinguish real
> > > remap windows and fake ones. I assumed that maybe someday there
> > > will be more than 4b target id so 0x80 as special case indicator
> > > leaves 7b of normal target id in the _current_ mapping.
> > > 
> > 
> > I'm also wondering about why we not care about target IDs being more
> > than 4 bits.
> > 
> > Jason: (I'm checking now but perhaps you know better than me):
> > Is there any MBus-architectural reason for you assuring the
> > target ID will always be within 4-bits?
> 
> The manuals I have for the register set say 4 bits is allocated for
> mbus targets.. Are yours different?
> 

Nope. 4 bits here as well.

> If they change it then the window register layout changes and then the
> mbus driver probably need to change as well.
> 

Okey, then.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
