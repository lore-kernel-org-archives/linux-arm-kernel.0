From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 15 Jul 2013 21:13:32 +0530
Subject: [PATCH 2/4] arm: omap5: hwmod: add missing ocp2scp hwmod data
In-Reply-To: <1373902423-28654-3-git-send-email-balbi@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
 <1373902423-28654-3-git-send-email-balbi@ti.com>
Message-ID: <51E418A4.9000109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 15 July 2013 09:03 PM, Felipe Balbi wrote:
> From: Benoit Cousson <benoit.cousson@linaro.org>
> 
> without that hwmod data, USB3 will not in OMAP5 boards.
> 
> While at that, also fix DTS data to pass reg property,
> otherwise driver won't probe.
> 
> Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi               |  3 +-
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 5c99f19..4e41409 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -652,10 +652,11 @@
>  			};
>  		};
>  
> -		ocp2scp {
> +		ocp2scp at 4a080000 {

While at that, can we also name it ocp2scp1 since we have 3 instances of
ocp2scp and it'll conflict when we want to add it for SATA and PCIE.

Thanks
Kishon
