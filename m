From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Feb 2016 13:52:19 +0100
Subject: [PATCH v4 0/7] ARM: dts: r-car: Add BRG support for (H)SCIF
In-Reply-To: <CAMuHMdWjEn6RSLPOYq=zhY_gk6Lx9xTD1x1G+1igoDr=3h1R5w@mail.gmail.com>
References: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
 <20160202102031.GD15554@verge.net.au>
 <CAMuHMdWjEn6RSLPOYq=zhY_gk6Lx9xTD1x1G+1igoDr=3h1R5w@mail.gmail.com>
Message-ID: <20160202125213.GH15554@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:38:05AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Feb 2, 2016 at 11:20 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jan 29, 2016 at 11:04:36AM +0100, Geert Uytterhoeven wrote:
> >> This patch series adds support for the Baud Rate Generator for External
> >> Clock (BRG), as found on SCIF and HSCIF, to the DTS files for all R-Car
> >> Gen1, Gen2, and Gen3 SoCs. This increases the range and accuracy of
> >> supported baud rates on (H)SCIF.
> >>
> >> Support for the extra clocks in the DT bindings and in the driver has
> >> been accepted in v4.5-rc1.
> >>
> >> Changes compared to v3:
> >>   - Change one-line summary prefix to match current arm-soc practices,
> >>   - Rebased,
> >>
> >> Changes compared to v2:
> >>   - Rename "int_clk" to "brg_int",
> >>   - Add support for R-Car M1A (r8a7778) and R-Car H1 (r8a7779),
> >>   - Add support for R-Car H2 (r8a7790), R-Car M2-N (r8a7793), and R-Car
> >>     E2 (r8a7794),
> >>   - Correct internal clock source ZS_CLK to S3D1 in patch description
> >>     for r8a7795,
> >>
> >> This has been tested on r8a7778/bockw, r8a7779/marzen, r8a7791/koelsch,
> >> r8a7794/alt, and r8a7795/salvator-x.
> >>
> >> Dependencies:
> >>   - renesas-devel-20160129-v4.5-rc1,
> >>   - series "[PATCH v4 0/7] ARM: dts: R-Car: Add SCIF fallback
> >>     compatibility strings",
> >>   - series "[PATCH v4 00/11] ARM: dts: shmobile: Rename the serial port
> >>     clock to fck",
> >>
> >> Thanks for applying!
> >
> > Is it safe to apply this in the light of the dependency on
> > renesas-devel-20160129-v4.5-rc1?
> 
> The dependency here (also for the other series) just means I rebased the
> series on top of renesas-devel-20160129-v4.5-rc1 + the mentioned
> series.
> 
> Do you have any DT changes there that are not queued for v4.6?

No, I don't think so.
