From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 4 Jun 2014 14:01:14 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140604115751.GH2520@sirena.org.uk>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
 <20140603173103.GA18004@red-moon>
 <20140603210424.GJ31751@sirena.org.uk>
 <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
 <20140604115751.GH2520@sirena.org.uk>
Message-ID: <20140604130114.GB10775@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 12:57:51PM +0100, Mark Brown wrote:
> On Wed, Jun 04, 2014 at 10:34:53AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jun 03, 2014 at 10:04:24PM +0100, Mark Brown wrote:
> 
> > > I'm having a really hard time seeing this as anything other than a step
> > > back.  Your change causes us to discard the higher affinity levels which
> > > seems like something we actively know to be misleading and means that we
> > > will be handing the scheduler two different identically numbered cores
> > > (all the affinity levels we do pay attention to will be identical) if we
> > > ever encounter such a system which is actively broken.
> 
> > If we ever encounter such systems we will deal with them when time
> > comes, DT can handle them and patching this code is trivial.
> 
> > All I am saying is, let's wait and see, there is no compelling need to
> > use aff3 (and aff2 on non-SMT systems) on current systems for the
> > topology.
> 
> That's still a kernel patch or having to write DT to get things working
> which for the sake of avoiding a couple of shift and or statements just
> seems unhelpful.  If it was just going to give poor performance that'd
> be one thing but it's actively broken.

What's broken ? Please provide me with an example and I will update the
patch.

Lorenzo
