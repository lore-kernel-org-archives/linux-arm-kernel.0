From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Feb 2017 18:06:10 +0000
Subject: [PATCH 1/2] arm64: dts: r8a7795: Upgrade to PSCI v1.0 to support
 Suspend-to-RAM
In-Reply-To: <1487350832-29820-2-git-send-email-geert+renesas@glider.be>
References: <1487350832-29820-1-git-send-email-geert+renesas@glider.be>
 <1487350832-29820-2-git-send-email-geert+renesas@glider.be>
Message-ID: <c35196c7-8b71-a7cf-cb4f-7359855346ee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/17 17:00, Geert Uytterhoeven wrote:
> From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> 
> From PSCI v1.0, Suspend-to-RAM is supported via SYSTEM_SUSPEND PSCI
> function call. Hence, upgrade PSCI version for R-Car H3 to support
> Suspend-to-RAM.
> 
> The Suspend-to-RAM is highly dependent on ARM Trusted Firwmare support
> since necessary callback functions will be registered after a query
> to ARM Trusted Firmware about SYSTEM_SUSPEND support.
> 
> Since PSCI v1.0 is backward compatible with PSCI v0.2, CPU Hotplug and
> CPUIdle should be able to work normally with this change.
> 

Why not retain "arm,psci-0.2" and just add "arm,psci-1.0" so that you
can continue to run older kernel without PSCI v1.0 or system suspend
support in case you need to backward compatible with older/stable kernel
versions.

> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Khiem: I've updated your email address.
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 98cd42f586b5fd62..4eae2d471d41ee55 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -29,7 +29,7 @@
>  	};
>  
>  	psci {
> -		compatible = "arm,psci-0.2";
> +		compatible = "arm,psci-1.0";
>  		method = "smc";
>  	};
>  
> 

-- 
Regards,
Sudeep
