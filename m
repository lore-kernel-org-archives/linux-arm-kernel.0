From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 14:02:50 +0200
Subject: [PATCH 3/9] Documentation: DT bindings: fix hda2codec_2x clock
 name for tegra30-hda
In-Reply-To: <ee8e9952dfdfd87da52f817fca0a6ad94a137742.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <ee8e9952dfdfd87da52f817fca0a6ad94a137742.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <20150505120249.GC30501@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:35:58PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix hda2codec_2x clock name in Tegra30 HDA controller device tree node
> documentation.
> While at it also fix coma vs. semicolon issue.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Takashi,

This series contains a couple of patches to the Tegra HDA driver and I
have a couple of outstanding patches myself. Would you be okay with me
collecting the patches in a branch and send them to you as a pull
request?

Thierry

> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
> index 13e2ef4..5032efa 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
> @@ -8,10 +8,10 @@ Required properties:
>  - interrupts : The interrupt from the HDA controller.
>  - clocks : Must contain an entry for each required entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
> -- clock-names : Must include the following entries: hda, hdacodec_2x, hda2hdmi
> +- clock-names : Must include the following entries: hda, hda2codec_2x, hda2hdmi
>  - resets : Must contain an entry for each entry in reset-names.
>    See ../reset/reset.txt for details.
> -- reset-names : Must include the following entries: hda, hdacodec_2x, hda2hdmi
> +- reset-names : Must include the following entries: hda, hda2codec_2x, hda2hdmi
>  
>  Example:
>  
> @@ -24,7 +24,7 @@ hda at 0,70030000 {
>  		 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
>  	clock-names = "hda", "hda2hdmi", "hda2codec_2x";
>  	resets = <&tegra_car 125>, /* hda */
> -		 <&tegra_car 128>; /* hda2hdmi */
> -		 <&tegra_car 111>, /* hda2codec_2x */
> +		 <&tegra_car 128>, /* hda2hdmi */
> +		 <&tegra_car 111>; /* hda2codec_2x */
>  	reset-names = "hda", "hda2hdmi", "hda2codec_2x";
>  };
> -- 
> 1.9.3
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/1e65e7b8/attachment-0001.sig>
