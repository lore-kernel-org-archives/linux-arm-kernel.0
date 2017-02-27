From: yuantian.tang@nxp.com (Y.T. Tang)
Date: Mon, 27 Feb 2017 02:19:16 +0000
Subject: [PATCH 1/2] dt-bindings: qoriq-clock: Add coreclk
In-Reply-To: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
References: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <VI1PR0402MB2848DEF2D443FF507CF03D78F0570@VI1PR0402MB2848.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PING!

Regards,
Yuantian

> -----Original Message-----
> From: yuantian.tang at nxp.com [mailto:yuantian.tang at nxp.com]
> Sent: Wednesday, February 15, 2017 1:48 PM
> To: mturquette at baylibre.com
> Cc: sboyd at codeaurora.org; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-clk at vger.kernel.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Y.T. Tang
> <yuantian.tang@nxp.com>; Scott Wood <oss@buserror.net>; Y.T. Tang
> <yuantian.tang@nxp.com>
> Subject: [PATCH 1/2] dt-bindings: qoriq-clock: Add coreclk
> 
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> ls1012a has separate input root clocks for core PLLs versus the platform PLL,
> with the latter described as sysclk in the hw docs.
> Update the qoriq-clock binding to allow a second input clock, named
> "coreclk".  If present, this clock will be used for the core PLLs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/qoriq-clock.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> index df9cb5a..97a9666 100644
> --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> @@ -55,6 +55,11 @@ Optional properties:
>  - clocks: If clock-frequency is not specified, sysclk may be provided
>  	as an input clock.  Either clock-frequency or clocks must be
>  	provided.
> +	A second input clock, called "coreclk", may be provided if
> +	core PLLs are based on a different input clock from the
> +	platform PLL.
> +- clock-names: Required if a coreclk is present.  Valid names are
> +	"sysclk" and "coreclk".
> 
>  2. Clock Provider
> 
> @@ -71,6 +76,7 @@ second cell is the clock index for the specified type.
>  	2	hwaccel		index (n in CLKCGnHWACSR)
>  	3	fman		0 for fm1, 1 for fm2
>  	4	platform pll	0=pll, 1=pll/2, 2=pll/3, 3=pll/4
> +	5	coreclk		must be 0
> 
>  3. Example
> 
> --
> 2.1.0.27.g96db324
