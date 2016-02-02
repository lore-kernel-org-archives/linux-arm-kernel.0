From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Feb 2016 14:16:47 +0100
Subject: [PATCH v4 0/9] ARM/arm64: dts: rcar: Enable SCIF_CLK frequency
 and pins
In-Reply-To: <20160202102132.GE15554@verge.net.au>
References: <1454062646-4826-1-git-send-email-geert+renesas@glider.be>
 <20160202102132.GE15554@verge.net.au>
Message-ID: <20160202131647.GJ15554@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 11:21:33AM +0100, Simon Horman wrote:
> On Fri, Jan 29, 2016 at 11:17:17AM +0100, Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> > 
> > This patch series adds support for the external crystal feeding SCIF_CLK
> > to (H)SCIF on the various Renesas R-Car Gen1, Gen2, and Gen3 development
> > boards.  This increases the range and accuracy of supported baud rates.
> > Support for this has been accepted in the driver in v4.5-rc1.
> > 
> > Changes compared to v3:
> >   - Change one-line summary prefix to match current arm-soc practices,
> >   - Tested on r8a7794/alt,
> >   - Rebased,
> > 
> > Changes compared to v2:
> >   - Add support for r8a7778/bockw, r8a7779/marzen, r8a7790/lager,
> >     r8a7791/porter, r8a7793/gose, r8a7794/alt, and r8a7794/silk,
> >   - Add Reviewed-by.
> > 
> > Testing:
> >   - This was tested locally on r8a7791/koelsch and r8a7795/salvator-x,
> >   - This was tested remotely on r8a7778/bockw, r8a7779/marzen, and
> >     r8a7794/alt,
> >   - This has been in renesas-drivers for a while, so I assume it has
> >     received basic testing on other boards,
> >   - Hints for various levels of testing:
> >       - Change the "dev_dbg" after "done:" in
> > 	drivers/tty/serial/sh-sci.c to "dev_info" to print clock and bit
> > 	rate,
> >       - "yes U | tr -d '\n' > /dev/ttySCx" outputs a square wave with a
> >         frequency of half the bit rate on TXD,
> >       - Modifying the frequency of SCIF_CLK causes garbage on the serial
> >         console, unless you compensate by changing the bit rate in
> >         /chosen/stdout-path,
> >       - If you disable the SCIF_CLK, the brg_int clock will be used. If
> >         you change that clock, you'll get garbage again.
> > 
> > Dependencies:
> >   - renesas-devel-20160129-v4.5-rc1,
> >   - series "[PATCH v4 0/7] ARM: dts: R-Car: Add SCIF fallback
> >     compatibility strings",
> >   - series "[PATCH v4 00/11] ARM: dts: shmobile: Rename the serial port
> >     clock to fck",
> >   - series "[PATCH v4 0/7] ARM: dts: r-car: Add BRG support for
> >     (H)SCIF".
> > 
> > Thanks for applying!
> 
> Is this safe to queue up in the light of the dependency on
> renesas-devel-20160129-v4.5-rc1?

Discussed elsewhere; I have queued this up.
