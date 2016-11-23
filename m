From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 16:42:41 +0530
Subject: [PATCH 3/3] ARM: dts: da850: Add node for pullup/pulldown pinconf
In-Reply-To: <1479871767-20160-4-git-send-email-david@lechnology.com>
References: <1479871767-20160-1-git-send-email-david@lechnology.com>
 <1479871767-20160-4-git-send-email-david@lechnology.com>
Message-ID: <8c3e6535-4b79-9731-f801-c13f007e48ab@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 November 2016 08:59 AM, David Lechner wrote:
> This SoC has a separate pin controller for configuring pullup/pulldown
> bias on groups of pins.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 8945815..1c0224c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -210,6 +210,11 @@
>  			};
>  
>  		};
> +		pinconf: pin-controller at 22c00c {
> +			compatible = "ti,da850-pupd";
> +			reg = <0x22c00c 0x8>;
> +			status = "disabled";
> +		};

Can you please place this below the i2c1 node. I am trying to keep the
nodes sorted by unit address. I know thats broken in many places today,
but lets add the new ones where they should eventually end up.

Thanks,
Sekhar
