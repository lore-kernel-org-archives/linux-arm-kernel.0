From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 6 Nov 2015 19:12:39 -0300
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2080A SoC
In-Reply-To: <1446846529-10613-1-git-send-email-German.Rivera@freescale.com>
References: <1446846529-10613-1-git-send-email-German.Rivera@freescale.com>
Message-ID: <CABxcv=n6UTcdskBv8fqRzfes+nCjPaFbCTDGRRDt=MStdepwWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello J. German,

On Fri, Nov 6, 2015 at 6:48 PM, J. German Rivera
<German.Rivera@freescale.com> wrote:
> Added sys-reboot node to the FSL's LS2080A SoC DT to leverage
> the ARM-generic reboot mechanism for this SoC. This mechanism
> is enabled through CONFIG_POWER_RESET_SYSCON.
>

What's in the changelog ends as a part of the commit message and
usually the change history is not added there...

> CHANGE HISTORY:
>
> Changes in v3:
> - Addressed comment from Stuart Yoder
>   * Fixed commit message to refer to LS2080A instead of LS2085A.
>
> Changes in v2:
> - Addressed comment form Stuart Yoder:
>   * Removed "@<address>" from reboot node
>
> Changes in v3:
> - Addressed comment form Stuart Yoder:
>   * Expose only the reset register
>
> Changes in v4:
> - Addressed comment from Arnd Bergmann:
>   * Changed compatible string to be more specific
>   * Changed node name to 'syscon' instead of 'rstcr'
>   * Changed address to lower case hex
> - Addressed comment form Stuart Yoder:
>   * Rebase on top of branch arm-soc/for-next
>
> Signed-off-by: J. German Rivera <German.Rivera@freescale.com>
> ---

...so the change history should be added here, between the '---'
marker line and the patch diff since that section is omitted by tools
like git-am when applying patches.

>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index e81cd48..a790a90 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -153,6 +153,18 @@
>                 };
>         };
>
> +       rstcr: syscon at 1e60000 {
> +               compatible = "fsl,ls2085a-rstcr", "syscon";
> +               reg = <0x0 0x1e60000 0x0 0x4>;
> +       };
> +
> +       reboot {
> +               compatible ="syscon-reboot";
> +               regmap = <&rstcr>;
> +               offset = <0x0>;
> +               mask = <0x2>;
> +       };
> +
>         timer {
>                 compatible = "arm,armv8-timer";
>                 interrupts = <1 13 0x8>, /* Physical Secure PPI, active-low */
> --

The patch looks good to me though.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
