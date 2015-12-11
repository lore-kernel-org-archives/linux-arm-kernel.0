From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 Dec 2015 14:25:25 +0300
Subject: [PATCH/RFC 03/19] ARM: shmobile: gose: add i2c2 bus to device tree
In-Reply-To: <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <566AB2A5.4090105@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/11/2015 5:52 AM, Simon Horman wrote:

> Activate i2c2 bus in r8a7793/gose device tree.
>
> Based on similar work for the r8a7791/koelsch by Wolfram Sang.
>
> Cc: Wolfram Sang <wsa@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/boot/dts/r8a7793-gose.dts | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> index 3e3122490650..9a71ff6d4474 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts
[...]
> @@ -135,3 +140,17 @@
>   		};
>   	};
>   };
> +
> +&i2c2 {
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	eeprom at 50 {
> +		compatible = "renesas,24c02";

    This is not a valid value -- the Renesas chip model is different from 24c02.

MBR, Sergei
