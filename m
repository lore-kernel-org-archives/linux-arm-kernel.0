From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 10:07:16 +0100
Subject: [PATCH 10/10] spi: s3c64xx: add device tree support
In-Reply-To: <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120509090716.GC28702@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:34:54AM +0530, Thomas Abraham wrote:

> +- gpios: The gpio specifier for clock, mosi and miso interface lines (in no
> +  particular order). The format of the gpio specifier depends on the gpio
> +  controller.

This seems odd...  This isn't a bitbanging controller, and surely the
driver will need to know which signal is which?  I suspect this is
actually for pinmux rather than to identify the signals but that should
at least be made clear and really should be being done using the pinmux
API.

> +  - samsung,spi-cs-gpio: A gpio specifier that specifies the gpio line used as
> +    the slave select line by the spi controller. The format of the gpio
> +    specifier depends on the gpio controller.

We should really have a binding for this at the SPI level (and ideally
some code to manage setting the GPIO too) - it's pretty common to use a
GPIO as /CS.
