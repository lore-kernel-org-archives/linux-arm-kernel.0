From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 22 Oct 2014 23:08:14 +0300
Subject: [PATCH v2 2/2] Documentation: dmaengine: Add a documentation for
 the dma controller API
In-Reply-To: <20141017112356.GO19438@lukather>
References: <1411746035-15882-1-git-send-email-maxime.ripard@free-electrons.com>
 <7725507.nuHj4C7OxF@avalon> <20141017112356.GO19438@lukather>
Message-ID: <3369016.M8rcEK3Bf6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Friday 17 October 2014 13:23:56 Maxime Ripard wrote:
> Hi Laurent,
> 
> Just getting back on something...
> 
> On Mon, Oct 06, 2014 at 03:09:48PM +0300, Laurent Pinchart wrote:
> > > +   * device_prep_dma_*
> > > +     - These functions are matching the capabilities you registered
> > > +       previously.
> > > +     - These functions all take the buffer or the scatterlist relevant
> > > +       for the transfer being prepared, and should create a hardware
> > > +       descriptor or a list of descriptors from it
> > > +     - These functions can be called from an interrupt context
> > > +     - Any allocation you might do should be using the GFP_NOWAIT
> > > +       flag, in order not to potentially sleep, but without depleting
> > > +       the emergency pool either.
> > 
> > You could add "Drivers should try to preallocate the data structures they
> > require to prepare a transfer."
> 
> Isn't that obvious?
> 
> I mean, if we're in this function, we're already preparing a
> transfer... And I would expect any programmer that followed CS101 to
> be able to allocate the memory it needs :)

I meant that memory should be pre-allocated earlier (at probe time or channel 
alloc time for instance) to avoid putting pressure on the nowait memory pool.

> The rest of the issues have been fixed, thanks!
> Maxime

-- 
Regards,

Laurent Pinchart
