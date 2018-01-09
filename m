From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 9 Jan 2018 12:02:04 +0100
Subject: [RESEND PATCH] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
In-Reply-To: <20180109055902.GA1306@arx-s1>
References: <20180109055902.GA1306@arx-s1>
Message-ID: <20180109110204.w6264q4xrullng6y@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 01:59:02PM +0800, hao_zhang wrote:
> Pin function can not be match correctly when SUNXI_PIN describe with
> mutiple variant and same function.
> 
> such as:
> on pinctrl-sun4i-a10.c
> 
> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> 		SUNXI_FUNCTION(0x0, "gpio_in"),
> 		SUNXI_FUNCTION(0x1, "gpio_out"),
> 		SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
> 			PINCTRL_SUN4I_A10 |
> 			PINCTRL_SUN7I_A20),
> 		SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
> 			PINCTRL_SUN8I_R40)),
> 
> it would always match to the first variant function
> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
> 
> so we should add variant compare on it.
> 
> Regards
> Hao
> 
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/d70f6fc5/attachment-0001.sig>
