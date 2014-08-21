From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 22 Aug 2014 00:53:53 +0400
Subject: [PATCH V2 3/5] ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
In-Reply-To: <1394450820-8158-3-git-send-email-wsa@the-dreams.de>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
 <1394450820-8158-3-git-send-email-wsa@the-dreams.de>
Message-ID: <53F65C61.6040700@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/10/2014 03:26 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa@sang-engineering.com>

> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>
> Changes since V1: use better compatible name "renesas,iic-r8a7791"

>   arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 858a8a923b00..f71670a5bfbc 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -27,6 +27,9 @@
>   		i2c3 = &i2c3;
>   		i2c4 = &i2c4;
>   		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
>   		spi0 = &qspi;
>   		spi1 = &msiof0;
>   		spi2 = &msiof1;
[...]
> @@ -244,6 +249,37 @@
>   		status = "disabled";
>   	};
>
> +	i2c6: i2c at e60b0000 {

    Hm, you finally labelled the nodes "iic[0-3]:" in the R8A7790 patch but 
not in this patch... what was the reason, did you just forgot to do it? Will 
you fix this or should I?

WBR, Sergei
