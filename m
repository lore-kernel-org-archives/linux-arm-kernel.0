From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 3 Aug 2015 14:22:19 -0400
Subject: [PATCH 1/2] ARM: dts: keystone: fix the clock node for mdio
In-Reply-To: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
References: <1438625518-21315-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <55BFB15B.8040207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 02:11 PM, Murali Karicheri wrote:
> Currently the MDIO clock is pointing to clkpa instead of clkcpgmac.
> MDIO is part of the ethss and the clock should be clkcpgmac.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>   arch/arm/boot/dts/keystone.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index e7a6f6d..6245a17 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -273,7 +273,7 @@
>   			#size-cells = <0>;
>   			reg		= <0x02090300 0x100>;
>   			status = "disabled";
> -			clocks = <&clkpa>;
> +			clocks = <&clkcpgmac>;
>   			clock-names = "fck";
>   			bus_freq	= <2500000>;
>   		};
>
Santosh,

This is a big fix and needs to go in v4.2-rc. So please review and apply 
asap. v4.2 is the first release that has netcp driver fully functional 
and I want to fix as many known bugs as possible.

Thanks.

-- 
Murali Karicheri
Linux Kernel, Keystone
