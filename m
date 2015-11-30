From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 30 Nov 2015 16:44:50 +0200
Subject: [PATCH v2 04/18] ARM: am57xx: cl-som-am57x: dts: add EEPROM
 support
In-Reply-To: <1448894037-1337-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-5-git-send-email-lifshitz@compulab.co.il>
 <1448894037-1337-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <565C60E2.5060002@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/15 16:33, Dmitry Lifshitz wrote:
> On-board EEPROM chip is used for storing a board production
> info.
> 
> Add module EEPROM support (over I2C4 bus).
> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
> 
>   v2:
> 
>    * Fix EEPROM chip model
> 
>  arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> index 9f15dda..695f250 100644
> --- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> +++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
> @@ -290,6 +290,12 @@
>  		compatible = "emmicro,em3027";
>  		reg = <0x56>;
>  	};
> +
> +	eeprom_module: atmel at 50 {
> +		compatible = "atmel,24c08";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
>  };
>  
>  
> 

-- 
Regards,
Igor.
