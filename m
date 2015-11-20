From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 14:58:09 +0100
Subject: [PATCH 01/11] dt-bindings: clock: add description of LPC32xx
 clock controller
In-Reply-To: <1447981511-29653-2-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <1447981511-29653-2-git-send-email-vz@mleia.com>
Message-ID: <3740707.LksPCoyRXC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 03:05:01 Vladimir Zapolskiy wrote:
> NXP LPC32xx SoC has a clocking and power control unit (CPC) as a part
> of system control block (SCB). CPC is supplied by two external
> oscillators and it manages core and most of peripheral
> clocks, the change adds description of DT bindings for clock
> controller found on LPC32xx SoC series.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> new file mode 100644
> index 0000000..20cbca3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> @@ -0,0 +1,30 @@
> +NXP LPC32xx Clock Controller
> +
> +Required properties:
> +- compatible: should be "nxp,lpc3220-clk"

Please use a specific model number without 'xx' wildcards. If you have
multiple chips that are mutually compatible, pick one as the base number
and then list the others as more specific instances, like

	compatible = "nxp,lpc3250-clk", "nxp,lpc3220-clk";

	Arnd
