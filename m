From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 27 Apr 2018 00:21:55 +0300
Subject: [PATCH 15/17] arm64: dts: r8a77965-salvator-x: Enable HDMI output
In-Reply-To: <20180426165346.494-16-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
 <20180426165346.494-16-kieran.bingham+renesas@ideasonboard.com>
Message-ID: <2345148.J1marZVneP@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kieran,

Thank you for the patch.

On Thursday, 26 April 2018 19:53:44 EEST Kieran Bingham wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> Enable the HDMI encoder for the M3N Salvator-X board and hook it up to
> the HDMI connector.
> 
> Based on a similar patches of the the Salvator-X board
> on the R8A7796 SoC device tree
> by Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

How about adding the VGA output too ? I think you can add both VGA and HDMI in 
a single patch that enables display in one go for the board. Same comment for 
the Salvator-XS.

> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  .../boot/dts/renesas/r8a77965-salvator-x.dts    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts index
> a2b8fb20fef8..11e8d43e9e11 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> @@ -31,3 +31,20 @@
>  	clock-names = "du.0", "du.1", "du.3", "lvds.0",
>  		      "dclkin.0", "dclkin.1", "dclkin.3";
>  };
> +
> +&hdmi0 {
> +	status = "okay";
> +
> +	ports {
> +		port at 1 {
> +			reg = <1>;
> +			rcar_dw_hdmi0_out: endpoint {
> +				remote-endpoint = <&hdmi0_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi0_con {
> +	remote-endpoint = <&rcar_dw_hdmi0_out>;
> +};

-- 
Regards,

Laurent Pinchart
