From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 17:52:57 -0700
Subject: [PATCH 2/2] ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard
In-Reply-To: <1476775542-4540-1-git-send-email-linus.walleij@linaro.org>
References: <1476775542-4540-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161019005257.GU8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18, Linus Walleij wrote:
> @@ -167,6 +190,41 @@
>  					bias-pull-up;
>  				};
>  			};
> +
> +			dragon_ebi2_pins: ebi2 {
> +				/*
> +				 * Pins used by EBI2 on the Dragonboard, actually only
> +				 * only CS2 is used by a real peripheral. CS0 is just
> +				 * routed to a test point.
> +				 */
> +				mux0 {
> +					/*
> +					 * Pins used by EBI2 on the Dragonboard, actually only
> +					 * only CS2 is used by a real peripheral. CS0 is just
> +					 * routed to a test point.
> +					 */

Same comment twice? Plus it says "only only CS2", so we probably
want to drop one "only".

> +					pins =
> +					    /* "gpio39", CS1A_N this is not good to mux */
> +					    "gpio40", /* CS2A_N */
> +					    "gpio134"; /* CS0_N testpoint TP29 */

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
