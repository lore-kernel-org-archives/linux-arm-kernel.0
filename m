From: nm@ti.com (Nishanth Menon)
Date: Fri, 31 Aug 2018 21:44:29 -0500
Subject: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
In-Reply-To: <20180828102642.26482-1-kishon@ti.com>
References: <20180828102642.26482-1-kishon@ti.com>
Message-ID: <20180901024429.fwnzriuqan3v55dj@akan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:56-20180828, Kishon Vijay Abraham I wrote:
[...]
>  		cbass_mcu: interconnect at 28380000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
> -				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
> -				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
> -				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> -				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
> -				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
> +			ranges = <0x28380000 0x00 0x28380000 0x03880000>, /* MCU NAVSS*/
> +				 <0x40200000 0x00 0x40200000 0x00900100>, /* First peripheral window */
> +				 <0x42040000 0x00 0x42040000 0x03ac2400>, /* WKUP */
> +				 <0x45100000 0x00 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> +				 <0x46000000 0x00 0x46000000 0x00200000>, /* CPSW */
> +				 <0x47000000 0x00 0x47000000 0x00068400>; /* OSPI space 1 */
>  


You might need #address-cells and #size-cells as 2 in MCU as
well.. Could you refer to response from Vignesh?
https://marc.info/?l=linux-arm-kernel&m=153572924921895&w=2

-- 
Regards,
Nishanth Menon
