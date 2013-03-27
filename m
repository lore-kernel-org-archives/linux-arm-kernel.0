From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 27 Mar 2013 12:54:19 +0100
Subject: [PATCH 01/11] staging: drm/imx: Add LDB support
In-Reply-To: <1364307246-9017-2-git-send-email-p.zabel@pengutronix.de>
References: <1364307246-9017-1-git-send-email-p.zabel@pengutronix.de>
 <1364307246-9017-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <5152DDEB.9020907@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 26/03/13 15:13, Philipp Zabel wrote:

> +static void imx_ldb_encoder_disable(struct drm_encoder *encoder)
> +{
> +	struct imx_ldb_channel *imx_ldb_ch = enc_to_imx_ldb_ch(encoder);
> +	struct imx_ldb *ldb = imx_ldb_ch->ldb;
> +
> +	if (gpio_is_valid(imx_ldb_ch->enable_gpio))
> +		gpio_set_value(imx_ldb_ch->enable_gpio, 0);
>
I get a compile error here:
drivers/staging/imx-drm/imx-ldb.c: In function ?imx_ldb_encoder_disable?:
drivers/staging/imx-drm/imx-ldb.c:283:2: error: implicit declaration of 
function ?gpio_is_valid? [-Werror=implicit-function-declaration]
drivers/staging/imx-drm/imx-ldb.c:283:30: error: ?struct 
imx_ldb_channel? has no member named ?enable_gpio?
drivers/staging/imx-drm/imx-ldb.c:284:3: error: implicit declaration of 
function ?gpio_set_value? [-Werror=implicit-function-declaration]
drivers/staging/imx-drm/imx-ldb.c:284:28: error: ?struct 
imx_ldb_channel? has no member named ?enable_gpio?

Adding #include <linux/gpio.h> fixes that but gives another error:
drivers/staging/imx-drm/imx-ldb.c: In function ?imx_ldb_encoder_disable?:
drivers/staging/imx-drm/imx-ldb.c:284:30: error: ?struct 
imx_ldb_channel? has no member named ?enable_gpio?
drivers/staging/imx-drm/imx-ldb.c:285:28: error: ?struct 
imx_ldb_channel? has no member named ?enable_gpio?

Commenting out the block gives a working driver.

Regards,

Martin
