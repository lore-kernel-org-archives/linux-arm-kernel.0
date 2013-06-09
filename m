From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Jun 2013 17:37:22 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130609143422.GA2353@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1695243.lt6nZouziV@wuerfel> <20130609143422.GA2353@localhost>
Message-ID: <2027719.ak85gut3pg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 June 2013 11:34:24 Ezequiel Garcia wrote:
> On Sun, Jun 09, 2013 at 03:42:24PM +0200, Arnd Bergmann wrote:
> > On Saturday 08 June 2013 15:38:52 Ezequiel Garcia wrote:
> > > On Fri, Jun 07, 2013 at 02:00:54PM -0600, Jason Gunthorpe wrote:
> > 
> > > Right. I think we have two options here for laying the DT ranges.
> > > 
> > > 1) This is the proposal implied in the patchset I sent:
> > > 
> > > mbus {
> > >     ranges = < we only put the internal-reg translation here>
> > >     devbus-bootcs {
> > >             ranges = <0 {target_id/attribute} {window_physical_base} {size}>
> > >     }
> > > }
> > 
> > As Jason explained, you cannot have the window_physical_base in the child
> > device, that just wouldn't work. I don't know if that's a typo or a thinko 
> > 
> 
> I'm not sure what you mean by "that just wouldn't work". I understand it
> may be a crappy DT layout, but it definitely works.

I didn't mean to imply that you hadn't tested it. I guess it works fine
if you put the same window_physical_base address into both the source
and destination side mbus ranges property, but then you have to pass
it three times in total and it gets really messy when you reassign it
to a different physical address.

	Arnd
