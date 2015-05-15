From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 May 2015 10:00:33 -0700
Subject: [PATCH 2/2 V3] ARM: dts: atlas7: add fixed frequency clocks in
 car node
In-Reply-To: <1431675587-8637-2-git-send-email-21cnbao@gmail.com>
References: <1431675587-8637-1-git-send-email-21cnbao@gmail.com>
 <1431675587-8637-2-git-send-email-21cnbao@gmail.com>
Message-ID: <20150515170033.GK31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Barry Song wrote:
> diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
> index a753178..7dad617 100644
> --- a/arch/arm/boot/dts/atlas7.dtsi
> +++ b/arch/arm/boot/dts/atlas7.dtsi
> @@ -183,6 +183,18 @@
>  				reg = <0x18620000 0x1000>;
>  				#clock-cells = <1>;
>  				#reset-cells = <1>;
> +				xinw {
> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-frequency = <32768>;
> +					clock-output-names = "xinw";
> +				};
> +				xin {
> +					compatible = "fixed-clock";
> +					#clock-cells = <0>;
> +					clock-frequency = <26000000>;
> +					clock-output-names = "xin";
> +				};
>  			};
>  		};
>  

Sorry I should have been clearer. I was suggesting putting these
nodes in DT at the root node "/" because they're part of the
board and not part of the SoC.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
