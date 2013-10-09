From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Oct 2013 12:38:11 +0900
Subject: [PATCH v2 1/3] clk: emev2: Add support for emev2 SMU clocks with
 DT
In-Reply-To: <CANqRtoRZM=5FYG7+fq5c+TQEuHtJRmcGP1CmMq5kO5Ayvg=W6w@mail.gmail.com>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143217.0611fba0c0d27d9c622759f3@ops.dti.ne.jp>
 <CANqRtoRZM=5FYG7+fq5c+TQEuHtJRmcGP1CmMq5kO5Ayvg=W6w@mail.gmail.com>
Message-ID: <20131009033807.GM15065@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 02:58:08PM +0900, Magnus Damm wrote:
> On Tue, Oct 8, 2013 at 2:32 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> > Device tree clock binding document for EMMA Mobile EV2 SMU,
> > And Common clock framework based implementation of it.
> > Following nodes are defined to describe clock tree.
> > - renesas,emev2-smu
> > - renesas,emev2-smu-clkdiv
> > - renesas,emev2-smu-gclk
> >
> > These bindings are designed manually based on
> >  19UH0037EJ1000_SMU : System Management Unit User's Manual
> >
> > So far, reparent is not implemented, and is fixed to index #0.
> > Clock tree description is not included, and should be provided
> > by device-tree.
> >
> > Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> > ---
> >  .../devicetree/bindings/clock/emev2-clock.txt      |  98 +++++++++++++++++++
> >  drivers/clk/Makefile                               |   1 +
> >  drivers/clk/shmobile/Makefile                      |   3 +
> >  drivers/clk/shmobile/clk-emev2.c                   | 104 +++++++++++++++++++++
> >  4 files changed, 206 insertions(+)
> 
> Thanks for cleaning up the Makefile bits, Yoshii-san.
> 
> This patch and the bindings look fine to me from a SoC point of view.
> Using these together with the topology information in emev2.dtsi makes
> it possible for us to use CCF and multiplatform as expected on the
> EMEV2 SoC.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks. I will send a pull request for this change to Mike Turquette.
