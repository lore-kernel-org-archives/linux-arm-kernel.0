From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 11:31:31 +0100
Subject: [RFC PATCH 1/4] regulator: Introduce OMAP regulator to control
 PMIC over VC/VP
In-Reply-To: <1369246717-4167-2-git-send-email-nm@ti.com>
References: <1369246717-4167-1-git-send-email-nm@ti.com>
 <1369246717-4167-2-git-send-email-nm@ti.com>
Message-ID: <20130610103131.GR31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 01:18:34PM -0500, Nishanth Menon wrote:

So, the biggest problem here has been patch 4 (having to have a hack to
deploy this stuff is a bit worrying) plus the general not having a real
driver thing.

> +- ti,i2c-slave-address - I2C slave address of the PMIC
> +- ti,i2c-voltage-register - I2C register address where voltage commands are
> +	to be set.
> +- ti,i2c-command-register - I2C register address where commands are to be set
> +	when OMAP enters low power state. This may be the same as
> +	ti,i2c-voltage-register depending on the PMIC.
> +- ti,slew-rate-microvolt - worst case slew rate of rise / fall for voltage
> +	transition in microvolts per microseconds (uV/uS)
> +- step-size-micro-volts - Step size in micovolts as to what one step in voltage
> +	selector increment translates to. See example.
> +- regulator-min-microvolt - Minimum voltage in microvolts which is supported by
> +	the PMIC in ti,step-size-microvolt increments. See example.
> +- regulator-max-microvolt - Maximum voltage in microvolts which is supported
> +	by the PMIC in ti,step-size-microvolt increments. See example.

The other thing is this whole business of encoding the properties of the
PMIC in the DT like this.  Paul Walmsley has started doing some work for
some similiar hardware where instead of doing this the regulator is in
the DT as normal and then the driver for the offloaded voltage scaling
gets the information about the register layout from the regulator
driver.  This is a bit neater overall and would cope with determining
which method to use at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/cc7d9d28/attachment.sig>
