From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 10 Jul 2012 15:38:44 +0100
Subject: [PATCH v4 5/6] spi: s3c64xx: Remove the 'set_level' callback
 from controller data
In-Reply-To: <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
References: <1341930459-25223-1-git-send-email-thomas.abraham@linaro.org>
 <1341930459-25223-6-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120710143844.GB11698@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 07:57:38PM +0530, Thomas Abraham wrote:
> The set_level callback in the controller data, which is used to configure
> the slave select line, cannot be supported when migrating the driver to
> device tree based discovery. Since all the platforms currently use gpio
> as the slave select line, this callback can be removed from the
> controller data and replaced with call to gpio_set_value in the driver.

This is currently buggy, BTW, as the driver never requests the GPIO.
