From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 09:58:23 -0600
Subject: [PATCH v9] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1373985202-16353-1-git-send-email-p.zabel@pengutronix.de>
References: <1373985202-16353-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <51E56D9F.30801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 08:33 AM, Philipp Zabel wrote:
> This driver implements a reset controller device that toggle a gpio
> connected to a reset pin of a peripheral IC. The delay between assertion
> and de-assertion of the reset signal can be configured via device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes since v8, as suggested by Shawn:
>  - added support for I2C gpios via gpio_set_value_cansleep
>  - switched from module_init to arch_initcall to avoid unnecessary
>    probe deferral of subsys_initcall drivers like gpio-pca953x.

For the record, I'm not convinced that either of those changes is correct.
