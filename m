From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 10:57:18 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.10
In-Reply-To: <20161121105315.GA19845@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
 <20161119014929.GE2543@localhost>
 <20161121105315.GA19845@verge.net.au>
Message-ID: <20161123095717.GA16339@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 11:53:18AM +0100, Simon Horman wrote:
> On Fri, Nov 18, 2016 at 05:49:29PM -0800, Olof Johansson wrote:
> > On Thu, Nov 17, 2016 at 03:11:45PM +0100, Simon Horman wrote:
> > > Hi Olof, Hi Kevin, Hi Arnd,
> > > 
> > > Please consider these second round of Renesas ARM based SoC DT updates for v4.10.
> > > 
> > > This pull request is based on a merge of:
> > > 
> > > * The previous round of such requests, tagged as renesas-dt-for-v4.10,
> > >   which I have already sent a pull-request for.
> > > * The rzg-clock-defs tag of Geert Uytterhoeven's renesas-driver's tree.
> > >   This is to provide dependencies for adding the r8a7743 and r8a7745 SoCs.
> > > * The "Second Round of Renesas ARM Based SoC Drivers Updates for v4.10",
> > >   tagged as renesas-drivers2-for-v4.10, which I have also sent a pull
> > >   request for. This is included to provide dependencies for adding device
> > >   nodes for PRR, and adding the r8a7743 and r8a7745 SoCs.
> > 
> > Again, nack. And again, I don't understand why you create dependencies that
> > aren't needed. Please fix.
> 
> Hi Olof,
> 
> I agree that calling out PRR above was incorrect. Please disregard that.
> 
> However, there are dependencies for adding r8a7743 and r8a7745 SoCs
> in the form of header files:
> 
> * The rzg-clock-defs tag provides dt-bindings/clock/r8a774[35]-cpg-mssr.h
> * The renesas-drivers2-for-v4.10 tag provides
>   dt-bindings/power/r8a774[35]-sysc.h
> 
> The drivers branches are usually pretty light-weight. But this time it is a
> bit heavy and you rightly raised some questions about it. After some
> discussion with Geert we'd like to suggest that for future releases
> we provide a "driver-defs" branch which both driver code and DT can
> depend on. Thus avoiding pulling (non essential) driver changes into the DT
> branch.
> 
> Unfortunately its a bit late to do that for v4.10 as the r8a7743 sysc
> driver and its defines were already accepted accepted together
> (renesas-drivers-for-v4.10 tag). So for this release we would be grateful
> if you could re-consider the renesas-drivers2-for-v4.10 tag given the
> feedback which Geert has provided. And in turn re-consider this pull
> request.

Hi again,

while the above remains my preferred option I would like to put another one
on the table in case it would help in any way for v4.10.

I could split this pull-request up as follows:
1. The patches that add the r8a774[35] SoCs:
   - r8a7743 depends on renesas-drivers-for-v4.10 and rzg-clock-defs
   - r8a7745 depends on renesas-drivers2-for-v4.10 and rzg-clock-defs
2. The patches rest of the patches
   - I believe these have no special dependencies
