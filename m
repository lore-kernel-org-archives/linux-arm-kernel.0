From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Sat, 27 Sep 2014 13:48:04 +0530
Subject: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Message-ID: <542672BC.3040306@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27-09-2014 06:28 AM, Lina Iyer wrote:
..

> +}
> +
> +static struct platform_driver qcom_cpuidle_plat_driver = {
> +	.probe	= qcom_cpuidle_probe,
> +	.driver = {
> +		.name = "qcom_cpuidle",
> +		.owner = THIS_MODULE,
.owner field can be removed here, as for drivers which
use the module_platform_driver API, this is overriden in
platform_driver_register anyway.
> +	},
> +};
> +
> +module_platform_driver(qcom_cpuidle_plat_driver);
> 
