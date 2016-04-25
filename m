From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 25 Apr 2016 17:25:58 +0300
Subject: [PATCH 1/6] arm64: dts: r8a7795: Don't disable referenced
 optional clocks
In-Reply-To: <1461593315-21307-2-git-send-email-geert+renesas@glider.be>
References: <1461593315-21307-1-git-send-email-geert+renesas@glider.be>
 <1461593315-21307-2-git-send-email-geert+renesas@glider.be>
Message-ID: <7f571e04-2e61-8299-5374-bddfe788da68@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/25/2016 5:08 PM, Geert Uytterhoeven wrote:

> clk_get() on a disabled clock node will return -EPROBE_DEFER, which can
> cause drivers to be deferred forever if such clocks are referenced in
> their devices' clocks properties.
>
> Update the various disabled external clock nodes to default to a
> frequency of 0, but don't disable them, to prevent this.
>
> Reported-by: J?rg Billeter <j@bitron.ch>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 5 +----
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 63d51059ae639e9d..263abaede2a82780 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -619,6 +619,7 @@
>  };
>
>  &pcie_bus_clk {
> +	clock-frequency = <100000000>;
>  	status = "okay";

    This line is no longer needed.

[...]

MBR, Sergei
