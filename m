From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 23 Jun 2015 14:55:22 +0530
Subject: [PATCH v6 7/9] nvmem: qfprom: Add bindings for qfprom
In-Reply-To: <1435014570-26434-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014570-26434-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55892602.2030809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]..

> +Example:
> +
> +	qfprom: qfprom at 00700000 {
> +		compatible 	= "qcom,qfprom";
> +		reg		= <0x00700000 0x8000>;
> +		...
> +		/* Data cells */
> +		tsens_calibration: calib at 404 {
> +			reg = <0x4404 0x10>;
> +		};
> +	};
> +
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	tsens {
> +		...
> +		nvmem-cell = <&tsens_calibration>;

Shouldn't this be nvmem-cells instead?

> +		nvmem-cell-names = "calibration";
> +	};
>
