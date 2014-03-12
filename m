From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 16:28:30 +0100
Subject: [PATCH] ARM: shmobile: compile drivers/sh for
 CONFIG_ARCH_SHMOBILE_MULTI
In-Reply-To: <1783624.XEvhdtDmJe@avalon>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdU4v9=BxTKk-=z4GE55KCuxuPry93OtGrTOzJ5ke8WT=g@mail.gmail.com>
 <1783624.XEvhdtDmJe@avalon>
Message-ID: <2988860.LSXScrXPRs@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wednesday 12 March 2014 15:18:46 Laurent Pinchart wrote:
> On Tuesday 11 March 2014 20:15:04 Geert Uytterhoeven wrote:
> > On Mon, Jan 20, 2014 at 11:52 PM, Laurent Pinchart wrote:
> > > On Monday 20 January 2014 15:56:43 Mark Brown wrote:
> > >> On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:
> > >> > The problem isn't as simple as it seems, and more advanced
> > >> > implementations that would allow listing clocks that should be
> > >> > managed automatically (or the other way around) would also add
> > >> > another level of complexity. The required information is platform-
> > >> > dependent, but we currently don't express it as such in DT.
> > >> 
> > >> Well, the set of clocks an IP requires will tend to be the same - it's
> > >> normally just that integrators may have done things like tie them
> > >> together or decide to spread confusion by renaming them.
> > > 
> > > That's the problem :-) How should the runtime PM core be given the list
> > > of clocks it needs to manage ? That information needs to come from
> > > somewhere.
> > 
> > Stirring the pot again...
> > 
> > Which clocks a device needs is expressed in DT with CCF.
> > In the simple case, the runtime PM core can just control them based on
> > device use.
> > In the complex case, the driver can regain control using its own pm
> > callbacks, right?
> 
> Sure, the driver can of course control the clocks manually in its PM
> callbacks if it needs to. The point, however, is to control the clocks from
> core code whenever possible. We thus need to define exact semantics to make
> sure each side knows what tasks to perform, and what to expect from the
> other side. For instance, in the DT case, the runtime PM core can easily
> get the list of the clocks used by the device from its DT node, but how can
> it know which clock(s) it should manage automatically and which clock(s) it
> should leave for the driver to control ?
> 
> > Probably I'm still missing something, as I haven't had enough exposure to
> > runtime PM and CCF ;-)

If you haven't seen it already, https://lkml.org/lkml/2014/1/31/290 
("[RFC/PATCH] base: platform: add generic clock handling for platform-bus") 
might be related.

-- 
Regards,

Laurent Pinchart
