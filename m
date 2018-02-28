From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 28 Feb 2018 15:51:34 +0000
Subject: [PATCH] arm64: dts: juno: fix size of GICv2m MSI frames
In-Reply-To: <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
References: <20180207143255.17003-3-marc.zyngier@arm.com>
 <1519832935-7338-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <36126393-ee37-40f1-9d5d-1c7f25c648dc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Cheers for sorting it out...

On 28/02/18 15:48, Sudeep Holla wrote:
> Currently the size of GICv2m MSI frames are listed as 4kB while the
> Juno TRM specifies 64kB for each of these MSI frames.
> 
> Though the devices connected themself might just use the first 4kB,

s/themself/themselves/

> to be consistent with the genaral practice of 64kB boundary alignment

s/genaral/general/

> to all the devices, lets keep the size as 64kB. This might also help
> in avoiding any surprise when passing the device to a VM.
> 
> This patch increase the size of each GICv2m MSI frames from 4kB to 64kB
> as per the specification.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   arch/arm64/boot/dts/arm/juno-base.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index f8088c45b060..eb749c50a736 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -72,25 +72,25 @@
>   		v2m_0: v2m at 0 {
>   			compatible = "arm,gic-v2m-frame";
>   			msi-controller;
> -			reg = <0 0 0 0x1000>;
> +			reg = <0 0 0 0x10000>;
>   		};
>   
>   		v2m at 10000 {
>   			compatible = "arm,gic-v2m-frame";
>   			msi-controller;
> -			reg = <0 0x10000 0 0x1000>;
> +			reg = <0 0x10000 0 0x10000>;
>   		};
>   
>   		v2m at 20000 {
>   			compatible = "arm,gic-v2m-frame";
>   			msi-controller;
> -			reg = <0 0x20000 0 0x1000>;
> +			reg = <0 0x20000 0 0x10000>;
>   		};
>   
>   		v2m at 30000 {
>   			compatible = "arm,gic-v2m-frame";
>   			msi-controller;
> -			reg = <0 0x30000 0 0x1000>;
> +			reg = <0 0x30000 0 0x10000>;
>   		};
>   	};
>   
> 
