From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Jan 2013 11:45:53 +0000
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <alpine.LFD.2.02.1301101132080.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk65PEVDS6vi=07g_hef8yXOR+mTYV_Nchu1fAuLnOJLOw@mail.gmail.com>
 <alpine.LFD.2.02.1301101132080.6300@xanadu.home>
Message-ID: <20130111114552.GB12560@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 04:47:09PM +0000, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Catalin Marinas wrote:
> > On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > --- /dev/null
> > > +++ b/arch/arm/common/bL_entry.c
> > ...
> > > +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> > 
> > IMHO, we should keep this array linear and ignore the cluster grouping
> > at this stage. This information could be added to latter patches that
> > actually need to know about the b.L topology.
> 
> That's virtually all of them.  Everything b.L related is always 
> expressed in terms of a cpu,cluster tuple at the low level.
> 
> > This would also imply that we treat the MPIDR just as an ID without 
> > digging into its bit layout.
> 
> That makes for too large an index space.  We always end up needing to 
> break the MPIDR into a cpu,cluster thing as the MPIDR bits are too 
> sparse.

You could find a way to compress this with some mask and shifts. We can
look at this later if we are to generalise this to non-b.L systems.

-- 
Catalin
