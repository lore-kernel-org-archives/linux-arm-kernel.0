From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 17:15:01 -0600
Subject: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
In-Reply-To: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
Message-ID: <52096C75.1030305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 04:55 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.

But the properties aren't globally standard; they apply specifically
anywhere that this particular Synopsis IP is present. As such, I think
at least a "synopsis," prefix is warranted.

And the driver should probably support both the old and new property
names for backwards-compatibility?
