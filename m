From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 21 Mar 2016 15:39:50 -0500
Subject: [PATCH 2/2] serial: amba-pl011: complete support to ZTE uart
In-Reply-To: <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
References: <1457920282-14823-1-git-send-email-jun.nie@linaro.org>
 <1457920282-14823-2-git-send-email-jun.nie@linaro.org>
Message-ID: <56F05C16.1030805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jun Nie wrote:
> @@ -2570,9 +2608,17 @@ static int pl011_uart_plat_probe(struct platform_device *pdev)
>   	if (!uap)
>   		return -ENOMEM;
>
> +	uap->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(uap->clk))
> +		return PTR_ERR(uap->clk);
> +

I don't this is supposed to be part of your patch, and it breaks my ACPI 
platform anyway.  Where did it come from?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
