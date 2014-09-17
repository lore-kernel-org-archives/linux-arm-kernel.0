From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Sep 2014 19:53:09 -0600
Subject: [PATCH] BCM2835: Add I2S driver to device tree
In-Reply-To: <1404895825-25668-1-git-send-email-broonie@kernel.org>
References: <1404895825-25668-1-git-send-email-broonie@kernel.org>
Message-ID: <5418E985.5090708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 02:50 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> [Tweaked slightly to disable by default -- broonie]
> 
> Signed-off-by: Florian Meier <florian.meier@koalo.de>
> Signed-off-by: Mark Brown <broonie@linaro.org>

I've belatedly forwarded this to arm-soc for application, except:

> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi

> +		bcm2835_i2s: i2s at 7e203000 {
> +			compatible = "brcm,bcm2835-i2s";
> +			reg = <0x7e203000 0x20>,
> +			      <0x7e101098 0x02>;
> +
> +			dmas = <&dma 2>,
> +			       <&dma 3>;
> +			dma-names = "tx", "rx";
> +		};

This node is already there (and even edited in this patch), so I dropped
that hunk.
