From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Aug 2013 02:52:14 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <CAOesGMgyQYTqObtvyJsVqxsrWz1rYTuA-qW4QwnZ+Co=1iKOBA@mail.gmail.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
 <20130802115334.GN2465@mudshark.cambridge.arm.com>
 <20130802142010.GC7533@kroah.com>
 <20130802160932.GG5292@mudshark.cambridge.arm.com>
 <20130802223247.GC28831@kroah.com>
 <CAOesGMgyQYTqObtvyJsVqxsrWz1rYTuA-qW4QwnZ+Co=1iKOBA@mail.gmail.com>
Message-ID: <20130807015214.GH15579@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 03, 2013 at 06:16:57AM +0100, Olof Johansson wrote:
> On Fri, Aug 2, 2013 at 3:32 PM, Greg KH <greg@kroah.com> wrote:
> > I don't scale if I'm forced to review every driver to ensure that they
> > shouldn't be using platform device and should be creating their own bus
> > type.  You can do that, along with the other ARM developers reviewing
> > these new subsystems and code being added.
> 
> For most new platforms, using basic platform_bus devices makes sense
> when the setup is simple and just has a few devices. It's only when
> they need to add support for {S,IO}MMUs and get the more advanced
> functionality going that things get messy and platform_bus stops
> working.

Right, but being more forward-looking, we will need to know this kind of
topological information to do simple things like (coherent) DMA or even
just to generate/route an interrupt.

> So, we have the option of having someone care about the {S,IO}MMU
> pieces, and when they spot the attempts to make that work, push them
> towards a proper bus architecture. Until then, the simpler solution is
> probably a reasonable idea compared to having newcomers worry about
> defining new bus architectures and raising the bar for what it takes
> to sort out the initial contributions and getting engaged upstream.

I take your point, but at the same time we don't want to find ourselves
suddenly landed with having to convert a bunch of drivers to sit on
different buses as an afterthought. There's likely some middle-ground that
is difficult to envisage up-front.

Will
