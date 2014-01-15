From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Jan 2014 11:25:17 +0000
Subject: [RFC 2/2] arm: Get rid of meminfo
In-Reply-To: <20140115105347.GM15937@n2100.arm.linux.org.uk>
References: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
 <1389765322-28582-3-git-send-email-lauraa@codeaurora.org>
 <20140115094957.GL15937@n2100.arm.linux.org.uk>
 <CAHkRjk4rkbLVReY7PQqO6DYB3erf6pRj4c4VoBe3iszkc9B5GA@mail.gmail.com>
 <20140115105347.GM15937@n2100.arm.linux.org.uk>
Message-ID: <20140115112516.GA17371@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 10:53:47AM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 15, 2014 at 10:22:02AM +0000, Catalin Marinas wrote:
> > On 15 January 2014 09:49, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Tue, Jan 14, 2014 at 09:55:22PM -0800, Laura Abbott wrote:
> > >> memblock is now fully integrated into the kernel and is the prefered
> > >> method for tracking memory. Rather than reinvent the wheel with
> > >> meminfo, migrate to using memblock directly instead of meminfo as
> > >> an intermediate.
> > >
> > > The reason I never killed meminfo was that for some of the functions here
> > > is that meminfo has a slightly different property to memblock.
> > >
> > > With meminfo, each sparsemem section mapping or discontigmem node must be
> > > specified as a separate bank of memory, even if it is contiguous with the
> > > previous block.  This is so that the functions which walk the page arrays
> > > can do so efficiently (without having to convert from a PFN to a struct
> > > page for every page in the system, which is very inefficient.)
> > 
> > pfn_to_page() conversion is indeed expensive with sparsemem (on
> > 32-bit) but does meminfo actually add a noticeable improvement to the
> > boot time? I don't think so but it's worth testing (something a
> > thousand cycles maximum would be lost in the noise).
> 
> Why do you ask about boot time?

Is meminfo used on a critical path at run-time?

-- 
Catalin
