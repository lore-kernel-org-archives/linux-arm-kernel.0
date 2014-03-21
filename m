From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Mar 2014 14:52:22 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320175253.GH11706@sirena.org.uk>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320171930.GA28238@arm.com>
 <20140320175253.GH11706@sirena.org.uk>
Message-ID: <20140321145222.GG13596@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 05:52:53PM +0000, Mark Brown wrote:
> On Thu, Mar 20, 2014 at 05:19:32PM +0000, Catalin Marinas wrote:
> > On Thu, Mar 20, 2014 at 01:43:57PM +0000, Mark Brown wrote:
> 
> > > To be honest at this point I think what I want to do is go back to the
> > > original approach of layering DT on top of MPIDR.  MPIDR is smaller and
> > > simpler code so seems more likely to make progress.  I really do expect
> > > that for a very large proportion of systems it'll be sufficient.
> 
> > Do you mean the physical MPIDR_EL1 or the DT representation of
> > MPIDR_EL1?
> 
> Well, the affinities need to be the same anyway (so we can tie the
> hardware to the description in DT) though we need to use the physical
> register to get the MT bit since the binding requires that this be
> omitted from the value stored in DT.  Lorenzo was keen on paying
> attention to the MT bit which does seem like a reasonable thing to do.

OK, as long as topology in DT takes priority (in case the hardware got
it wrong).

-- 
Catalin
