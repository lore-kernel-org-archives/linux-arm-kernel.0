From: horms@verge.net.au (Simon Horman)
Date: Mon, 13 Mar 2017 10:16:02 +0100
Subject: [PATCH v2 0/6] ARM: dts: renesas: Add INTC-SYS clock to device
 tree
In-Reply-To: <CAMuHMdVmd5+QW00XRL4qzO85RrCsu_7Bu15ah1rcFZ=eGgDSug@mail.gmail.com>
References: <1488819491-26097-1-git-send-email-geert+renesas@glider.be>
 <20170310092159.GE21820@verge.net.au>
 <CAMuHMdVmd5+QW00XRL4qzO85RrCsu_7Bu15ah1rcFZ=eGgDSug@mail.gmail.com>
Message-ID: <20170313091602.GB19296@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 12:19:07PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Mar 10, 2017 at 10:21 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Mar 06, 2017 at 05:58:05PM +0100, Geert Uytterhoeven wrote:
> >> This patch series improves the topology description in DT of the ARM GIC
> >> on Renesas SoCs using the legacy CPG/MSTP bindings (R-Mobile APE6 and
> >> R-Car Gen2).  It describes the INTC-SYS clock, links the GIC to its
> >> module clock, and adds the GIC to the SYSC "always on" PM Domain.
> >>
> >> Note that currently the GIC-400 driver doesn't support module clocks nor
> >> Runtime PM, so this must be handled as a critical clock.  Hence this
> >> series depends on commit e34084fb9a023d1d ("clk: renesas: mstp: Make
> >> INTC-SYS a critical clock"), which is in v4.11-rc1.
> >>
> >> This series is the counterpart of "[PATCH 0/4] ARM/arm64: dts: renesas:
> >> Link ARM GIC to clock and clock domain" for SoCs not yet migrated to the
> >> new CPG/MSSR driver.  The latter is already part of v4.11-rc1 as it had
> >> less dependencies.
> >>
> >> Changes compared to v1:
> >>   - Add missing "power-domains" property,
> >>   - Add clock-names property,
> >>   - Rebased on top of CPG Clock Domain and R-Car SYSC PM Domain support,
> >>   - Add r8a7792 patch,
> >>   - Please refer to the individual patch changelogs for more details
> >>     (v1 dates back to 2014).
> >>
> >> Thanks for applying!
> >
> > Thanks, done.
> 
> Thanks, but it seems you forgot "ARM: dts: r8a7793: Add INTC-SYS clock to
> device tree"?

Sorry about that, I have it queued up now.
