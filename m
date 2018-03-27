From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 27 Mar 2018 10:12:49 -0700
Subject: [PATCH v5 06/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1
 board file
In-Reply-To: <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-7-git-send-email-sricharan@codeaurora.org>
Message-ID: <20180327171249.GI1403@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
> +

If this is the board and qcom-ipq4019-ap.dk04.1.dtsi is the platform
file then the compatible should be here and not there. Also qcom,ipq4019
is not an awesome compatible for a board file.

> +	soc {
> +		dma at 7984000 {
> +			status = "ok";
> +		};
> +
> +		qpic-nand at 79b0000 {
> +			pinctrl-0 = <&nand_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};

nand_pins defines the muxing and is defined in the other dtsi. So please
move these pinctrl-* properties to the dtsi.

As long as the node is disabled the pinctrl state won't be applied
anyways.


If there are electrical properties that needs to be specified you can
override the pinctrl state in the board specific file.

Regards,
Bjorn
