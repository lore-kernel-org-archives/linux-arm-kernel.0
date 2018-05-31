From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 19:53:02 -0500
Subject: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
In-Reply-To: <1527234671-31755-7-git-send-email-aisheng.dong@nxp.com>
References: <1527234671-31755-1-git-send-email-aisheng.dong@nxp.com>
 <1527234671-31755-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180531005302.GA13776@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 03:51:08PM +0800, Dong Aisheng wrote:
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> 
> Note IMX7ULP has two clock domains: M4 and A7. This binding doc
> is only for A7 clock domain.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v2->v3:
>  * no changes
> v1->v2: no changes
> ---
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  62 ++++++++++++
>  include/dt-bindings/clock/imx7ulp-clock.h          | 105 +++++++++++++++++++++
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> new file mode 100644
> index 0000000..76ea3c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> @@ -0,0 +1,62 @@
> +* Clock bindings for Freescale i.MX7ULP
> +
> +i.MX7ULP Clock functions are under joint control of the System
> +Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> +modules, and Core Mode Controller (CMC)1 blocks
> +
> +The clocking scheme provides clear separation between M4 domain
> +and A7 domain. Except for a few clock sources shared between two
> +domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> +and and the Fast IRC clock (FIRCLK), clock sources and clock
> +management are separated and contained within each domain.
> +
> +M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> +A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> +
> +Note: this binding doc is only for A7 clock domain.
> +
> +Required properties:
> +
> +- compatible:	Should be "fsl,imx7ulp-clock".
> +- reg : 	Should contain registers location and length for scg1,
> +		pcc2 and pcc3.
> +- reg-names:	Should contain the according reg names "scg1", "pcc2"
> +		and "pcc3".

Sounds like separate blocks. These should each be their own node and 
binding.
