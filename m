From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 27 Apr 2017 09:38:36 -0700
Subject: [PATCH 2/2] ARM: dts: NSP: Add Thermal Support
In-Reply-To: <1493153351-12698-3-git-send-email-jon.mason@broadcom.com>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
 <1493153351-12698-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170427163834.GD18276@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 04:49:11PM -0400, Jon Mason wrote:
> Add thermal support via the ns-thermal driver and create a single
> thermal zone for the entire SoC.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index 832795b..be6fcfb 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -383,6 +383,12 @@
>  			      <0x3f408 0x04>;
>  		};
>  
> +		thermal: thermal at 3f2c0 {
> +			compatible = "brcm,ns-thermal";
> +			reg = <0x3f2c0 0x10>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
>  		sata_phy: sata_phy at 40100 {
>  			compatible = "brcm,iproc-nsp-sata-phy";
>  			reg = <0x40100 0x340>;
> @@ -533,4 +539,24 @@
>  			brcm,pcie-msi-inten;
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <1000>;
> +			coefficients = <(-556) 418000>;
> +			thermal-sensors = <&thermal>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature     = <125000>;
> +					hysteresis      = <0>;
> +					type            = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170427/0f0f5b1a/attachment.sig>
