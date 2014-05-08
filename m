From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 09 May 2014 03:54:45 +0400
Subject: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
In-Reply-To: <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
Message-ID: <536C1945.1000601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/17/2014 01:44 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa@sang-engineering.com>

> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index d4b9bba..b3f75d7 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -108,10 +108,29 @@
>   	clock-frequency = <20000000>;
>   };
>
> +&i2c2 {
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	eeprom at 50 {
> +		compatible = "renesas,24c02";

    This is not quite right: Renesas' part is called differently, and you're 
carrying the other vendor's naming onto Renesas parts. I'd just say "24c02" 
(which I'll do in the Henninger board patch).

WBR, Sergei
