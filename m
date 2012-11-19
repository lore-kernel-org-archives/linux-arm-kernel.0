From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 14:41:07 -0700
Subject: [PATCH 1/2] ARM: dts: support pinctrl single in aspenite
In-Reply-To: <1353049345-6954-1-git-send-email-haojian.zhuang@gmail.com>
References: <1353049345-6954-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <50AAA773.2090807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 12:02 AM, Haojian Zhuang wrote:
> Support pinctrl-single driver in aspenite DTS file.

> diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi

> +			pmx: pinmux at d401e000 {

> +				range0: range at d401e04c {
> +					/* GPIO0 ~ GPIO15 */
> +					reg = <0xd401e04c 0x40>;
> +					/* gpio base & gpio func */
> +					pinctrl-single,gpio = <0 5>;

So I see that the "0" here is the first GPIO number, but what is the
"5"? The comment says GPIO 0..15, but I don't see anywhere that the "16"
count of GPIOs/pins is defined.
