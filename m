From: broonie@debian.org (Mark Brown)
Date: Sun, 9 Nov 2014 12:37:53 +0000
Subject: sound: enable sound support on n900 on devicetree-based boot
In-Reply-To: <20141109120222.GA3815@amd>
References: <20141109120222.GA3815@amd>
Message-ID: <20141109123753.GO2722@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 01:02:22PM +0100, Pavel Machek wrote:
> 
> With device tree, it is possible (and encouraged) to build N900
> kernels without CONFIG_MACH_NOKIA_RX51. Update config file to enable
> the driver build in this case.

Please do try to use subject lines reflecting the style for the
subsystem.

>  config SND_OMAP_SOC_RX51
>  	tristate "SoC Audio support for Nokia RX-51"
> -	depends on SND_OMAP_SOC && ARM && (MACH_NOKIA_RX51 || COMPILE_TEST) && I2C
> +	depends on SND_OMAP_SOC && ARM && I2C

Please also update the config text so users have a chance to figure out
that this driver is the one they need for their system - I guess most
people won't know what RX-51 is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141109/d707f4bf/attachment.sig>
