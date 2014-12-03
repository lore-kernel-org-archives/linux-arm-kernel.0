From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 21:13:18 +0100
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <547F3CAC.9050105@arm.com>
References: <547F3CAC.9050105@arm.com>
Message-ID: <2041200.ZjakFFAZAU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 16:39:08 Andrew Jackson wrote:
> Convert to driver to use either platform_data or device-tree for configuration
> of the device.  When using device-tree, the I2S block's configuration is read
> from the relevant registers: this reduces the amount of information required in
> the device tree.
> 
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>

I don't think we even have to worry about the platform_data case here:
the only platform using this hardware in Linux is arm/mach-spear, and
it defines a device node with a binding that is similar to the one you
document here but that is not implemented in the driver.

So, I think for all practical purposes we can assume that nobody cares
if you make incompatible changes as long as you don't introduce build
regression.

Also, please adapt the 	arch/arm/boot/dts/spear13*.dts{,i} files
as good as you can. They are broken in other ways too that you don't
have to fix, just make them conform to the binding you add.

	Arnd
