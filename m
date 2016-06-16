From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 Jun 2016 17:11:39 -0700
Subject: [PATCH 5/5] ARM: dts: add Qualcomm APQ8060-based Dragonboard
In-Reply-To: <1465918259-11138-6-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160616001139.GM28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14, Linus Walleij wrote:
> +
> +/ {
> +	model = "Qualcomm APQ8060 Dragonboard";
> +	compatible = "qcom,apq8060-dragonboard", "qcom,msm8660";
> +
> +	aliases {
> +		serial0 = &gsbi12_serial;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		/* Main power of the board: 3.7V */
> +		vph: regulator-fixed at 1 {

So does this mean we shouldn't have the @1 here because there's no
reg property?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
