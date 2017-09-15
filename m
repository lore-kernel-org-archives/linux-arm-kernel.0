From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Sep 2017 09:25:05 +0200
Subject: [PATCH 04/11] soc: renesas: rcar-sysc: add R8A77970 support
In-Reply-To: <CAMuHMdXLbg2WwtWvG+zBa5MOT3qXr2Fv-U4AJ0=eLfE2VG1LKg@mail.gmail.com>
References: <20170912210518.203740259@cogentembedded.com>
 <CAMuHMdXLbg2WwtWvG+zBa5MOT3qXr2Fv-U4AJ0=eLfE2VG1LKg@mail.gmail.com>
Message-ID: <20170915072504.GA3924@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 13, 2017 at 10:36:23AM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Tue, Sep 12, 2017 at 10:37 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Add support for R-Car V3M (R8A77970) SoC power areas to the R-Car SYSC
> > driver.
> >
> > Based on the original (and large) patch by Daisuke Matsushita
> > <daisuke.matsushita.ns@hitachi.com>.
> >
> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> > --- /dev/null
> > +++ renesas/drivers/soc/renesas/r8a77970-sysc.c
> > @@ -0,0 +1,39 @@
> 
> > +#include <linux/bug.h>
> 
> I think this include is no longer needed since commit c7acec713d14c6ce
> ("kernel.h: handle pointers to arrays better in container_of()").
> 
> > +static const struct rcar_sysc_area r8a77970_areas[] __initconst = {
> 
> > +       { "a3ir",       0x180, 0, R8A77970_PD_A3IR,     R8A77970_PD_ALWAYS_ON },
> > +       { "a2ir0",      0x400, 0, R8A77970_PD_A2IR0,    R8A77970_PD_ALWAYS_ON },
> > +       { "a2ir1",      0x400, 1, R8A77970_PD_A2IR1,    R8A77970_PD_A2IR0 },
> > +       { "a2ir2",      0x400, 2, R8A77970_PD_A2IR2,    R8A77970_PD_A2IR0 },
> > +       { "a2ir3",      0x400, 3, R8A77970_PD_A2IR3,    R8A77970_PD_A2IR0 },
> > +       { "a2sc0",      0x400, 4, R8A77970_PD_A2SC0,    R8A77970_PD_ALWAYS_ON },
> > +       { "a2sc1",      0x400, 5, R8A77970_PD_A2SC1,    R8A77970_PD_A2SC0 },
> 
> According to Figure 9.2(b) "Power domain structure (R-Car V3M)" and Table 9.4
> "Power domains", all of A2IR[0-3] and A2SC[01] are direct children of A3IR.
> 
> BTW, the bit indices "4" resp. "5" for A2SC[01] don't match Section 9.2.5
> "Power Control Registers for A2IR" (which uses "0" resp. "1"), but I assume
> that's just a typo in the datasheet, as those would conflict with A2IR[01], and
> the would conflict with the documentation for other R-Car Gen3 SoCs.
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sergei,

please address Geert's review and repost when you are ready.
I believe patches 1-3 of this series have been applied.
I have marked patches 4 (this one) onwards as "Changes Requested"
indicating that I expect all those patches to be reposted when you are ready.
