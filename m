From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 4 Oct 2016 18:41:00 +0530
Subject: [PATCH v2 3/4] ARM: dts: dra72-evm-revc: fix correct phy delay
 and impedance settings
In-Reply-To: <20161004125607.10569-4-mugunthanvnm@ti.com>
References: <20161004125607.10569-1-mugunthanvnm@ti.com>
 <20161004125607.10569-4-mugunthanvnm@ti.com>
Message-ID: <a4ef7fc1-73f7-7136-0d60-6ce8a8ff33b9@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 04 October 2016 06:26 PM, Mugunthan V N wrote:
> The default impedance settings of the phy is not the optimal
> value, due to this the second ethernet is not working. Fix it
> with correct values which makes the second ethernet port to work.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  arch/arm/boot/dts/dra72-evm-revc.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra72-evm-revc.dts b/arch/arm/boot/dts/dra72-evm-revc.dts
> index f9cfd3b..d626cd7 100644
> --- a/arch/arm/boot/dts/dra72-evm-revc.dts
> +++ b/arch/arm/boot/dts/dra72-evm-revc.dts
> @@ -62,6 +62,7 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> +		ti,min-output-imepdance;

s/imepdance/impedance

>  	};
>  
>  	dp83867_1: ethernet-phy at 3 {
> @@ -69,5 +70,6 @@
>  		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
>  		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_NS>;
>  		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
> +		ti,min-output-imepdance;

same here.

Thanks and regards,
Lokesh

>  	};
>  };
> 
