From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 11:18:37 -0600
Subject: [PATCH 1/2] dt-bindings: qoriq-clock: Add coreclk
In-Reply-To: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
References: <1487137656-4006-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20170227171837.eymnyebgn7ocsp7w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 01:47:35PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> ls1012a has separate input root clocks for core PLLs versus the platform
> PLL, with the latter described as sysclk in the hw docs.
> Update the qoriq-clock binding to allow a second input clock, named
> "coreclk".  If present, this clock will be used for the core PLLs.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/qoriq-clock.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

The change looks fine, but sounds like Scott should remain the author 
(or agree he shouldn't be).

> 
> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
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
> 
