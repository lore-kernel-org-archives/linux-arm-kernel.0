From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 8 Jan 2018 19:30:13 +0530
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <1515377863-20358-2-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
Message-ID: <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:47 AM, David Lechner wrote:
> This adds a new binding for the PLL IP blocks in the mach-davinci family
> of processors. Currently, only the SYSCLKn and AUXCLK outputs are needed,
> but in the future additional child nodes could be added for OBSCLK and
> BPDIV.
> 
> Note: Although these PLL controllers are very similar to the TI Keystone
> SoCs, we are not re-using those bindings. The Keystone bindings use a
> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs

Not sure what is meant by "legacy one-node-per-clock binding"

> have a slightly different PLL register layout and a number of quirks that
> can't be handled by the existing bindings, so the keystone bindings could
> not be used as-is anyway.

Right, I think different register layout between the processors is the
main reason for a new driver. This should be sufficient reason IMO.

> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../devicetree/bindings/clock/ti/davinci/pll.txt   | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> new file mode 100644
> index 0000000..99bf5da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
> @@ -0,0 +1,47 @@
> +Binding for TI DaVinci PLL Controllers
> +
> +The PLL provides clocks to most of the components on the SoC. In addition
> +to the PLL itself, this controller also contains bypasses, gates, dividers,
> +an multiplexers for various clock signals.
> +
> +Required properties:
> +- compatible: shall be one of:
> +	- "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
> +	- "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX

These PLLs are same IP so they should use the same compatible. You can
initialize both PLLs for DA850 based on the same compatible.

Thanks,
Sekhar
