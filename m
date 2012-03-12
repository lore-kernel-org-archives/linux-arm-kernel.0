From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 14:21:43 +0000
Subject: [PATCH 5/5] mmc: sdhci-s3c: setup pins using pinctrl interface
In-Reply-To: <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <1331469965-28846-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120312142143.GC14020@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 06:16:05PM +0530, Thomas Abraham wrote:
> The platform specific callback to setup the sdhci pin mux and pin config
> is removed and the pinctrl subsystem interface is used to setup the
> mux and config.

You've only added pinctrl support for Exynos but this driver is also
used by SoCs going back to s3c24xx era.  Either all those SoCs need to
be converted to use pinctrl or the driver needs to understand both
methods (eg, using pinctrl if no callback is supplied).
