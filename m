From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 15 Jun 2011 13:31:24 +0100
Subject: GPIO vs. other drivers order
In-Reply-To: <BANLkTikJtAqgKHGU2kBbMQdS5GSszxihYg@mail.gmail.com>
References: <ita6o6$od6$1@dough.gmane.org>
	<20110615120629.GC24628@pulham.picochip.com>
	<BANLkTikJtAqgKHGU2kBbMQdS5GSszxihYg@mail.gmail.com>
Message-ID: <20110615123123.GE24628@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 04:18:42PM +0400, Dmitry Eremin-Solenikov wrote:
> On 6/15/11, Jamie Iles <jamie@jamieiles.com> wrote:
> > Hi Dmitry,
> >
> > On Wed, Jun 15, 2011 at 11:57:58AM +0000, Dmitry Eremin-Solenikov wrote:
> >> Hello, colleagues,
> >>
> >> I'm currently looking at cleaning up LoCoMo and Scoop2 drivers (custom
> >> Sharp ASICs used by Sharp Zaurus PDAs). One of the problems I'm stuck at
> >> is about GPIO parts of that chips: there are plenty of other devices
> >> depending on GPIO pins working correctly (ranging from board code
> >> itself up to several other sub-drivers).
> >>
> >> What would be the better approach: to create a basic-mmio-gpio node (and
> >> hope for the order of initialization to be correct) or embed bgpio into
> >> main driver and call all necessary hooks directly from it?
> >
> > Currently the basic-mmio-gpio platform driver is registed with a
> > module_initcall so this may be too late for any machines that need GPIO
> > in their .init_machine callback.  Moving the registration to a
> > postcore_initcall (as OMAP does) and I don't recall seeing any
> > objections to this.
> 
> Will someone commit this or I'll have to submit this as a patch?

There aren't any patches for this circulating at the moment so feel free 
to submit one.  If not, then I'm happy to do so.

Jamie
