From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Feb 2015 18:35:36 +0300
Subject: [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big
 Network v2
In-Reply-To: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
References: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <54EB48C8.6010506@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/23/2015 4:02 PM, Simon Guinot wrote:

> On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> controlled by using the gpio-fan driver.

> This patch adds the gpio-fan alarm description in the net2big_v2 DTS.

> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>   arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
>   1 file changed, 5 insertions(+)

> diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
> index 53dc37a3b687..e4f7e497379f 100644
> --- a/arch/arm/boot/dts/kirkwood-net2big.dts
> +++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> @@ -27,6 +27,11 @@
>   		device_type = "memory";
>   		reg = <0x00000000 0x10000000>;
>   	};
> +
> +	gpio_fan {

    The ePAPR standard says that node name should be generic, so "fan" would 
fit better here...

> +		compatible = "gpio-fan";
> +		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> +	};
>   };

WBR, Sergei
