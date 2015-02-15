From: Jianwei.Wang@freescale.com (Jianwei.Wang at freescale.com)
Date: Sun, 15 Feb 2015 10:12:18 +0000
Subject: [PATCH 2/3] arm/dts/ls1021a: Add DCU dts node
In-Reply-To: <1423848488.4107.5.camel@aoeu.buserror.net>
References: <1423825436-47780-1-git-send-email-b52261@freescale.com>
 <1423825436-47780-2-git-send-email-b52261@freescale.com>,
 <1423848488.4107.5.camel@aoeu.buserror.net>
Message-ID: <1423995136260.31542@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My careless, I'll add "big?endia" to fsl,dcfb.txt next version.
________________________________________
???: Wood Scott-B07421
????: 2015?2?14? 1:28:08
???: Wang Jianwei-B52261
??: dri-devel at lists.freedesktop.org; jbarnes at virtuousgeek.org; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Wang Huan-B18965; Xiubo Li
??: Re: [PATCH 2/3] arm/dts/ls1021a: Add DCU dts node

On Fri, 2015-02-13 at 19:03 +0800, Jianwei Wang wrote:
> Add DCU node, DCU is a display controller of Freescale
> named 2D-ACE.
>
> Signed-off-by: Alison Wang <b18965@freescale.com>
> Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
> Signed-off-by: Jianwei Wang <b52261@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..28c37f1 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -383,6 +383,17 @@
>                                <&platform_clk 1>;
>               };
>
> +             dcfb: dcfb at 2ce0000 {
> +                     compatible = "fsl,ls1021a-dcfb";
> +                     reg = <0x0 0x2ce0000 0x0 0x10000>;
> +                     interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +                     clocks = <&platform_clk 0>;
> +                     clock-names = "dcfb";
> +                     scfg-controller = <&scfg>;
> +                     big-endian;
> +                     status = "disabled";
> +             };

I don't see "big-endian" in the dcfb binding.

-Scott
