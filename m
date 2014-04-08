From: svarbanov@mm-sol.com (Stanimir Vabanov)
Date: Wed, 09 Apr 2014 01:02:24 +0300
Subject: [PATCH v2] ARM: qcom: Add initial APQ8064 SoC and IFC6410 board
 device trees
In-Reply-To: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
References: <1396972391-11759-1-git-send-email-galak@codeaurora.org>
Message-ID: <534471F0.5050800@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

<snip>

> +		intc: interrupt-controller at 2000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = < 0x02000000 0x1000 >,
> +			      < 0x02002000 0x1000 >;

extra space around numbers.

I wonder what is the preferred way of describing the properties:

reg = <0x02000000 0x1000>,
      <0x02002000 0x1000>;
or

reg = <0x02000000 0x1000>, <0x02002000 0x1000>;

This file mixes the above two ways of describing.

> +		};
> +
> +		timer at 200a000 {
> +			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			interrupts = <1 1 0x301>,
> +				     <1 2 0x301>,
> +				     <1 3 0x301>;
> +			reg = <0x0200a000 0x100>;
> +			clock-frequency = <27000000>,
> +					  <32768>;
> +			cpu-offset = <0x80000>;
> +		};
> +
> +		acc0: clock-controller at 2088000 {
> +			compatible = "qcom,kpss-acc-v1";
> +			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +		};
> +

regards,
Stan
