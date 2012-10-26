From: chris.brand@broadcom.com (Chris Brand)
Date: Fri, 26 Oct 2012 20:52:26 +0000
Subject: [PATCH v4] pwm: vt8500: Update vt8500 PWM driver support
In-Reply-To: <1351100330-26072-1-git-send-email-linux@prisktech.co.nz>
References: <1351100330-26072-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <4EE5B48738DDED408878C97C8E050A8B1BD17DD2@SJEXCHMB05.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> @@ -124,6 +156,12 @@ static int __devinit pwm_probe(struct
> platform_device *pdev)
>  	chip->chip.base = -1;
>  	chip->chip.npwm = VT8500_NR_PWMS;
> 
> +	chip->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR_OR_NULL(chip->clk)) {
> +		dev_err(&pdev->dev, "clock source not specified\n");
> +		return PTR_ERR(chip->clk);
> +	}
> +

Do you want IS_ERR() rather than IS_ERR_OR_NULL() here ?
Otherwise you may return PTR_ERR(NULL).

Chris
