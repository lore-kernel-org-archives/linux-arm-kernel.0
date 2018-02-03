From: absahu@codeaurora.org (Abhishek Sahu)
Date: Sat, 03 Feb 2018 16:47:39 +0530
Subject: [PATCH 06/15] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <1517202689-14212-7-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <a32d3a776c7a3f5c88a9a26200bff915@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-29 10:41, Sricharan R wrote:
> Add the common parts for the dk04 boards.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 147

  <snip>
> +
> +			nand_pins: nand_pins {
> +				pullups {
> +					pins = "gpio52", "gpio53",
> "gpio58",
> +						"gpio59";
> +					function = "qpic";
> +					bias-pull-up;
> +				};
> +
> +				pulldowns {
> +					pins = "gpio54", "gpio55",
> "gpio56",
> +						"gpio57", "gpio60",
> "gpio61",
> +						"gpio62", "gpio63",
> "gpio64",
> +						"gpio65", "gpio66",
> "gpio67",
> +						"gpio68", "gpio69";
> +					function = "qpic";
> +					bias-pull-down;
> +				};
> +			};

  Can you please check once why do we need pull-up and
  pull-down for NAND pins. The NAND chip will be mounted
  over board itself so board design should take care of
  required pull up and pull downs.

  Also, some of the above pins like gpio52 will be only used
  for LCD so we can remove those pins. Later on, when LCD
  support will be added, we can add those pins.

  Thanks,
  Abhishek
