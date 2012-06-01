From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jun 2012 04:35:30 -0700
Subject: [RFC PATCH 06/11] OMAP2+: use control module mfd driver in
 omap_type
In-Reply-To: <20120528112417.GF3923@besouro>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-7-git-send-email-eduardo.valentin@ti.com>
 <4FBF80D5.2000600@ti.com>
 <CAMQu2gyjJdJZKAf+TJwQfQ2BgAXe_s-soTcs7Am6O4+yy=7cLQ@mail.gmail.com>
 <20120528112417.GF3923@besouro>
Message-ID: <20120601113530.GN12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eduardo Valentin <eduardo.valentin@ti.com> [120528 04:28]:
> On Mon, May 28, 2012 at 03:32:50PM +0530, Shilimkar, Santosh wrote:
> > On Fri, May 25, 2012 at 6:23 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > >
> > > OK, not really related to that patch, but the previous cpu_is_omap24xx makes
> > > me think of that :-)
> > >
> > > What about the omap<X>_check_revision used by cpu_is_XXX?
> > >
> > > This call is the very first one to require the control module access in
> > > order to get the ID_CODE inside the control module.
> > >
> > > So far it still use that ugly hard coded phys -> virtual address macro that
> > > is sued for that.
> > >
> > Agree with Benoits comment. One way to deal with this is,
> > store the register offset with init and then just use it here.
> > 
> > That way you can get rid of all cpu_is_XXXX() from this function.
> 
> I see. I need to check how this storing would look like.
> Probably we can do the storing when the early device gets probed.

As this needs to be initialized very early I'd rather avoid dependencies
to drivers for this. Maybe that register can be read and saved when the
device gets built? It's ioremapped anyways at that point.

That is assuming we don't need to export it to drivers or constantly
read it..

Tony
