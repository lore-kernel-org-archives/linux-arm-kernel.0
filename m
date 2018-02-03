From: absahu@codeaurora.org (Abhishek Sahu)
Date: Sat, 03 Feb 2018 17:03:40 +0530
Subject: [PATCH 08/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c5
 board file
In-Reply-To: <1517202689-14212-9-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-9-git-send-email-sricharan@codeaurora.org>
Message-ID: <87d9fe82685c00e331b7c1156d2967eb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-29 10:41, Sricharan R wrote:
> dk04.1-c5 has a spinand connected to spi bus0 chipselect 1.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c5.dts | 23
> +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)

  <snip>

> +		spi_0: spi at 78b5000 { /* BLSP1 QUP1 */
> +			status = "ok";
> +			cs-gpios = <&tlmm 12 0>, <&tlmm 45 0>;

  Same applies here also. We need to add pinumx
  for gpio45.

  Thanks,
  Abhishek

> +			num-cs = <2>;
> +
> +			mt29f at 1 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "spinand,mt29f";
> +				reg = <1>;
> +				spi-max-frequency = <24000000>;
> +			};
> +		};
> +	};
> +};
