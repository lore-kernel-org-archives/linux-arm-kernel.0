From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 May 2015 08:39:58 -0700
Subject: [PATCH] arm: dts: Enable beaglebone cape-manager
In-Reply-To: <1431504292-32132-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1431504292-32132-1-git-send-email-pantelis.antoniou@konsulko.com>
Message-ID: <20150514153957.GK15563@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150513 01:06]:
> Enable the cape manager on the beaglebone family of boards.

I don't think we have the "ti,bone-capemgr" binding in use yet
in Linux next?

An ack from the DT people would be good to have here for the
binding.

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 236b7db..28d9764 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -375,3 +375,45 @@
>  &sham {
>  	status = "okay";
>  };
> +
> +/* the cape manager */
> +/ {
> +	bone_capemgr {
> +		compatible = "ti,bone-capemgr";
> +		status = "okay";
> +
> +		eeprom = <&baseboard_data>;
> +
> +		/* map board revisions to compatible definitions */
> +		baseboardmaps {
> +			baseboard_beaglebone: board at 0 {
> +				board-name = "A335BONE";
> +				compatible-name = "ti,beaglebone";
> +			};
> +
> +			baseboard_beaglebone_black: board at 1 {
> +				board-name = "A335BNLT";
> +				compatible-name = "ti,beaglebone-black";
> +			};
> +		};
> +
> +		/* only 4 slots defined */
> +		slots {
> +			slot at 0 {
> +				eeprom = <&cape0_data>;
> +			};
> +
> +			slot at 1 {
> +				eeprom = <&cape1_data>;
> +			};
> +
> +			slot at 2 {
> +				eeprom = <&cape2_data>;
> +			};
> +
> +			slot at 3 {
> +				eeprom = <&cape3_data>;
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.12
> 
