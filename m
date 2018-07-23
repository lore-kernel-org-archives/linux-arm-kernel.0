From: horms@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 13:17:09 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.19
In-Reply-To: <20180721214620.ahdwbrdzzcdz4boc@localhost>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
 <20180721214620.ahdwbrdzzcdz4boc@localhost>
Message-ID: <20180723111709.twudvtpf5nl7gope@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 21, 2018 at 02:46:20PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Fri, Jul 20, 2018 at 02:04:41PM +0200, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC DT updates for v4.19.
> > 
> > 
> > The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> > 
> >   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v4.19
> > 
> > for you to fetch changes up to 8757b1eb3ff92012be1670a0f0d2cf9f3d9a17ff:
> > 
> >   ARM: dts: r8a77470: Use r8a77470-cpg-mssr binding definitions (2018-07-18 10:47:01 +0200)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC DT Updates for v4.19
> > 
> > * RZ/G1C (r8a77470) SoC
> > 
> >   Use r8a77470-cpg-mssr binding definitions, which are now available in
> >   mainline, instead of numeric indices.
> 
> I shorted this up a bit to "RZ/G1C (r8a77470) SoC: Use r8a77470-cpg-mssr
> binding definitions"
> 
> > * Add GR-Peach audio camera shield support with MT9V111 image sensor
> > 
> >   This allows use of this shield with the RZ/A1 (r7s72100) SoC based
> >   GR-Peach board.
> 
> This second paragraph is redundant.
> 
> > * Add initial support for RZ/N1D (r9a06g032) SoC and its RZN1D-DB board
> > 
> > * Use SPDX identifiers in DT for all SoCs and boards
> > 
> > * Add missing OPP properties for all CPUs on various SoCs
> > 
> >   This fixes SoCs where OPP properties were only defined for CPU0
> >   which allows correct operation regardless of the order in which
> >   CPUs are brought up.
> 
> Pruned this out too, description is clear enough (we've seen a bunch of these
> patches by now :).
> 
> > * Drop MTD partitioning from DT
> > 
> >   This does not describe HW and providing partitioning on the kernel
> >   command line provides a more flexible solution.
> 
> I disagree that command line is to be preferred. It's awkward to keep
> it updated everywhere, and for your product you're unlikely to change
> the partition scheme very often. But it's up to you, I suppose. Seems
> like needless churn though.
> 
> Device-tree is there to describe the _platform_, and sure, flash partitioning
> isn't part of the pure hardware, but it is non-probable and we've got the
> tradition of keeping those things in the DT.
> 
> I've also replied to the patch, let's bring the discussion there.
> 
> > * Add missing PMIC nodes to R-Car Gen2 M2-W (r8a7791) based porter board
> > 
> >   This describes the two PMIC devices present on the porter and
> >   connects CPU DVS supply.
> 
> Again, no need for the paragraph in the tag, I'd say.
> 
> 
> Not merged this branch based on the above MTD comments.

Thanks, I'll post a v2 with the MTD change dropped and updates
to the commit message as per your suggestions.
