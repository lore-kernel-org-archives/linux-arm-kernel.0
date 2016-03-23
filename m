From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 Mar 2016 10:07:31 +0900
Subject: [PATCH 00/13] ARM, arm64: dts: Remove unnecessary
 clock-output-names properties
In-Reply-To: <CAMuHMdV7F==8cMr-CQgiBGC9NhnojNN-6d2Ph+uaHjtbCFW4pQ@mail.gmail.com>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdV7F==8cMr-CQgiBGC9NhnojNN-6d2Ph+uaHjtbCFW4pQ@mail.gmail.com>
Message-ID: <20160323010731.GD5950@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 11:18:37AM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 22, 2016 at 2:40 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > this series updates the device trees of Renesas ARM based SoCs.
> >
> > * Fixed rate and fixed factor clocks do not require an
> >   clock-output-names property.
> > * Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
> >   optional") Renesas div6 clocks do not require a clock-output-names
> >   property.
> >
> > In the above cases there is only one clock output and its name is taken
> > from that of the clock node.
> >
> > Accordingly, remove the unnecessary clock-output-names properties and as
> > necessary update the node names. The zb_clk is excluded from this rename
> > as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
> > named zb_clk for the r8a73a4 and sh73a0 SoCs.
> >
> > Based on renesas-devel-20160318-v4.5
> >
> > Simon Horman (13):
> >   ARM: dts: r7s72100: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a73a4: Remove unnecessary clock-output-names properties
> >   ARM: dts: sh73a0: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7740: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7778: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7779: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7791: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7793: Remove unnecessary clock-output-names properties
> >   ARM: dts: r8a7794: Remove unnecessary clock-output-names properties
> >   ARM: dts: gose: Remove unnecessary clock-output-names properties
> >   ARM: dts: koelsch: Remove unnecessary clock-output-names properties
> >   ARM: dts: porter: Remove unnecessary clock-output-names properties
> >   ARM: dts: lager: Remove unnecessary clock-output-names properties
> 
> For 1, 4-13:
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks I have queued up those patches, and posted updated versions of
patches 2 and 3.
