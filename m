From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Dec 2016 13:17:16 +0100
Subject: [PATCH v3 6/6] mfd: dt: Move syscon bindings to syscon
 subdirectory
In-Reply-To: <1481630734.3112.40.camel@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161213110710.GV3625@dell.home> <1481630734.3112.40.camel@aj.id.au>
Message-ID: <5094120.Y7DXfRGTEm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 13, 2016 10:35:34 PM CET Andrew Jeffery wrote:
> On Tue, 2016-12-13 at 11:07 +0000, Lee Jones wrote:
> > On Tue, 13 Dec 2016, Andrew Jeffery wrote:
> > > On Mon, 2016-12-12 at 09:39 -0600, Rob Herring wrote:
> > > > On Tue, Dec 06, 2016 at 01:53:21PM +1100, Andrew Jeffery wrote:
> > > 
> > > Lee's next email in the chain poked Arnd for an opinion, but Arnd
> > > didn't reply.
> > > 
> > > I don't mind. I moved these bindings separately so we could just drop
> > > the patch if there was push-back. If we drop the whole idea I'll need
> > > to apply a small fix to patch 5/6 to avoid creating the syscon
> > > subdirectory.
> > 
> > The sub-directory is a good idea for drivers who are *solely* syscon
> > based.
> > 
> 
> Yes, I wasn't saying otherwise, just commenting on my motivation and
> approach.
> 
> As far as I can tell all of the bindings I move here describe solely
> syscon-based devices.
> 

But do we know which ones they are?

In principle, any syscon device node can have a specialized driver
exporting an interface, the bindings always allow it to be done
one way or the other, and we may change the driver or run a different
OS that has decided differently.

	Arnd
