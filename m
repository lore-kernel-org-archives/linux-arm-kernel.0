From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Oct 2014 18:22:07 -0700
Subject: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <5435E33F.4060709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 02:41 PM, Lina Iyer wrote:
> +
> +static int qcom_cpuidle_probe(struct platform_device *pdev)
> +{
> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
> +	int ret;
> +
> +	qcom_idle_enter = pdev->dev.platform_data;
> +	if (!qcom_idle_enter)
> +		return -EFAULT;

Is this ever true? Let's just drop the whole check.



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
