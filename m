From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Feb 2016 11:20:32 +0100
Subject: [PATCH v4 0/7] ARM: dts: r-car: Add BRG support for (H)SCIF
In-Reply-To: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
References: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160202102031.GD15554@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 11:04:36AM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds support for the Baud Rate Generator for External
> Clock (BRG), as found on SCIF and HSCIF, to the DTS files for all R-Car
> Gen1, Gen2, and Gen3 SoCs. This increases the range and accuracy of
> supported baud rates on (H)SCIF.
> 
> Support for the extra clocks in the DT bindings and in the driver has
> been accepted in v4.5-rc1.  
> 
> Changes compared to v3:
>   - Change one-line summary prefix to match current arm-soc practices,
>   - Rebased,
> 
> Changes compared to v2:
>   - Rename "int_clk" to "brg_int",
>   - Add support for R-Car M1A (r8a7778) and R-Car H1 (r8a7779),
>   - Add support for R-Car H2 (r8a7790), R-Car M2-N (r8a7793), and R-Car
>     E2 (r8a7794),
>   - Correct internal clock source ZS_CLK to S3D1 in patch description
>     for r8a7795, 
> 
> This has been tested on r8a7778/bockw, r8a7779/marzen, r8a7791/koelsch,
> r8a7794/alt, and r8a7795/salvator-x.
> 
> Dependencies:
>   - renesas-devel-20160129-v4.5-rc1,
>   - series "[PATCH v4 0/7] ARM: dts: R-Car: Add SCIF fallback
>     compatibility strings",
>   - series "[PATCH v4 00/11] ARM: dts: shmobile: Rename the serial port
>     clock to fck",
> 
> Thanks for applying!

Is it safe to apply this in the light of the dependency on
renesas-devel-20160129-v4.5-rc1?

> Geert Uytterhoeven (7):
>   ARM: dts: r8a7778: Add BRG support for SCIF
>   ARM: dts: r8a7779: Add BRG support for SCIF
>   ARM: dts: r8a7790: Add BRG support for (H)SCIF
>   ARM: dts: r8a7791: Add BRG support for (H)SCIF
>   ARM: dts: r8a7793: Add BRG support for SCIF
>   ARM: dts: r8a7794: Add BRG support for (H)SCIF
>   arm64: dts: r8a7795: Add BRG support for (H)SCIF
> 
>  arch/arm/boot/dts/r8a7778.dtsi           | 39 +++++++++++------
>  arch/arm/boot/dts/r8a7779.dtsi           | 39 +++++++++++------
>  arch/arm/boot/dts/r8a7790.dtsi           | 29 +++++++++----
>  arch/arm/boot/dts/r8a7791.dtsi           | 54 +++++++++++++++--------
>  arch/arm/boot/dts/r8a7793.dtsi           | 54 +++++++++++++++--------
>  arch/arm/boot/dts/r8a7794.dtsi           | 54 +++++++++++++++--------
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 74 ++++++++++++++++++++++----------
>  7 files changed, 235 insertions(+), 108 deletions(-)
