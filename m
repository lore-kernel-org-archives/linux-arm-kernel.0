From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Feb 2017 17:51:36 +0000
Subject: [PATCH 2/3] arm64: dts: r8a7796: Add CA53 L2 cache-controller node
In-Reply-To: <1487345435-1088-3-git-send-email-geert+renesas@glider.be>
References: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
 <1487345435-1088-3-git-send-email-geert+renesas@glider.be>
Message-ID: <05e43b97-eaa3-f1df-1fc8-b7bab05cc89c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/02/17 15:30, Geert Uytterhoeven wrote:
> Add a device node for the Cortex-A53 L2 cache-controller.
> 
> The L2 cache for the Cortex-A53 CPU cores is 512 KiB large (organized as
> 32 KiB x 16 ways).
> 
> Extracted from a patch by Takeshi Kihara in the BSP.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index 6c0a65abf9fd09eb..d848e94d7282e5aa 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -62,6 +62,14 @@
>  			cache-unified;
>  			cache-level = <2>;
>  		};
> +
> +		L2_CA53: cache-controller at 100 {
> +			compatible = "cache";
> +			reg = <0x100>;

Is this not integrated L2 cache ? IIUC reg is MPIDR of the cpu and
representing it as cache controller with some reg value doesn't sound
correct IMO.

> +			power-domains = <&sysc R8A7796_PD_CA53_SCU>;
> +			cache-unified;
> +			cache-level = <2>;
> +		};
>  	};
>  
>  	extal_clk: extal {
> 

-- 
Regards,
Sudeep
