From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 20:02:50 +0100
Subject: [PATCH 07/10] S3C64XX I2S: Added third I2S Controller.
In-Reply-To: <1253008959-10633-1-git-send-email-jassi.brar@samsung.com>
References: <1253008959-10633-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916190250.GC6257@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:39PM +0900, Jassi wrote:

> +		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
> +		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
> +		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);

The GPIO function defines here don't match mainline, meaning this won't
build.  You want S3C64XX_GPC4_I2S0_V40_DO and so on.
