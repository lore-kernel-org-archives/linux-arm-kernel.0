From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 20 Oct 2017 17:16:49 +0800
Subject: [RFC resend 3/4] arm64: dts: mt8173: Fix drm subsystem
In-Reply-To: <20171019112610.13645-4-mbrugger@suse.com>
References: <20171019112610.13645-1-mbrugger@suse.com>
 <20171019112610.13645-4-mbrugger@suse.com>
Message-ID: <1508491009.23296.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Matthias:

On Thu, 2017-10-19 at 13:26 +0200, Matthias Brugger wrote:
> DRM subysystem and clock driver shared the same compatible mmsys.
> This stopped does not work, as only the first driver for a compatible
> gets probed. We change the comaptible to the new DRM identifier to fix
> this.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b99a27372965..89db0a3f5950 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -803,6 +803,11 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		dispsys: display-system {
> +			compatible = "mediatek,mt2701-dispsys";

Why do you probe "mediatek,mt2701-dispsys" in mt8173.dtsi?

Regards,
CK

> +			mediatek,mmsys = <&mmsys>;
> +		}
> +
>  		mdp_rdma0: rdma at 14001000 {
>  			compatible = "mediatek,mt8173-mdp-rdma",
>  				     "mediatek,mt8173-mdp";
