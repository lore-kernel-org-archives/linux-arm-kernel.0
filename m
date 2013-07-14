From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 14 Jul 2013 21:58:43 +0200
Subject: [PATCH v2] rtc: Add MOXA ART RTC driver
In-Reply-To: <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
References: <1373464848-28146-1-git-send-email-jonas.jensen@gmail.com>
 <1373550711-18828-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <201307142158.44027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 July 2013, Jonas Jensen wrote:
> Add RTC driver for MOXA ART SoCs.
> +
> +#define GPIO_EM1240_OUTPUT			1
> +#define GPIO_EM1240_INPUT			0
> +
> +#define GPIO_RTC_SCLK				(5)
> +#define GPIO_RTC_DATA				(6)
> +#define GPIO_RTC_RESET				(7)

Since this is a DT-only platform, you should not really have hardcoded GPIO
numbers.

> +	devm_gpio_request(&pdev->dev, GPIO_RTC_DATA, "rtc_data");
> +	devm_gpio_request(&pdev->dev, GPIO_RTC_SCLK, "rtc_sclk");
> +	devm_gpio_request(&pdev->dev, GPIO_RTC_RESET, "rtc_reset");

Instead, you should use of_get_named_gpio() here, and add a binding document
that describes the names.

	Arnd
