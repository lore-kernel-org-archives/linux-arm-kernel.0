From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 12:00:36 -0800
Subject: [PATCH v10 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <1416593037-27527-4-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <54763164.2080103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> +
> +static const struct platform_device_info  qcom_cpuidle_info = {

nitpick, why two spaces between info and qcom here?

> +	.name	= "qcom_cpuidle",
> +	.id	= -1,
> +	.data = &lpm_ops,
> +	.size_data = sizeof(lpm_ops),
> +};

This struct could go on the stack too so that it doesn't lay around forever.

>
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("SAW power controller driver");
> +MODULE_ALIAS("saw");

"platform:saw" please. Namespacing aliases is good.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
