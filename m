From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Feb 2018 14:31:48 +0200
Subject: [PATCH 1/4] arm64: dts: renesas: r8a77995: add FCPVB node
In-Reply-To: <1518474330-8713-2-git-send-email-kbingham@kernel.org>
References: <1518474330-8713-1-git-send-email-kbingham@kernel.org>
 <1518474330-8713-2-git-send-email-kbingham@kernel.org>
Message-ID: <7882079.DMVypBKPF4@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Tuesday, 13 February 2018 00:25:26 EET Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> The FCPVB handles the interface between the VSPB and memory.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> b/arch/arm64/boot/dts/renesas/r8a77995.dtsi index
> cd3c6a30fc47..6cf935d307d9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -691,6 +691,15 @@
>  			#phy-cells = <0>;
>  			status = "disabled";
>  		};
> +
> +		fcpvb0: fcp at fe96f000 {
> +			compatible = "renesas,fcpv";
> +			reg = <0 0xfe96f000 0 0x200>;
> +			clocks = <&cpg CPG_MOD 607>;
> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +			resets = <&cpg 607>;
> +			iommus = <&ipmmu_vp0 5>;
> +		};
>  	};
> 
>  	timer {

-- 
Regards,

Laurent Pinchart
