From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Oct 2014 13:18:44 +0100
Subject: [PATCH 06/10] arm64: Update booting.txt to reserved-memory nodes
In-Reply-To: <CACxGe6tpKMk7e6OZSG2O-JWGT_jUTE3-4u_4Nn=d4QNccJd+-Q@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <b56c0def845535b41b6c00bffdd9d91de5ddae5c.1414099246.git.geoff@infradead.org>
 <20141024105432.GE24265@leverpostej>
 <CACxGe6tpKMk7e6OZSG2O-JWGT_jUTE3-4u_4Nn=d4QNccJd+-Q@mail.gmail.com>
Message-ID: <20141024121844.GG24265@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 12:04:00PM +0100, Grant Likely wrote:
> On Fri, Oct 24, 2014 at 11:54 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Oct 24, 2014 at 12:10:58AM +0100, Geoff Levand wrote:
> > > Change any reference of device tree '/memreserve/' entries in the arm64
> > > booting.txt to refer to 'reserved-memory nodes'.  Reserved-memory nodes
> > > are the preferred method of specifying reserved memory.
> >
> > Per my comments on patch 5, I don't think this change is sufficient.
> >
> > However, we should probably update the document to allow reserved-memory
> > nodes.
> >
> > On an unrelated note we probably need to work out how reserved-memory
> > interacts with the UEFI memory map -- unmappable regions shouldn't be
> > described by UEFI and I hope people don't use reserved-memory as a
> > workaround for broken UEFI tables.
> 
> 
> When booting with UEFI, the boot stub will clear out all memory nodes
> and (should) clear out reserved regions so that the kernel can use the
> UEFI memory map as authoritative.

We clear memory nodes and memreserves currently.

I was thinking about reserved-memory nodes (for CMA and such), which we
don't currently clear.

Mark.
