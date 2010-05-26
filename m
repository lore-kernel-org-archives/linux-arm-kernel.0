From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 25 May 2010 20:31:00 -0400 (EDT)
Subject: [patch 4/5] orion/kirkwood: Add i2s support
In-Reply-To: <20100525122341.443140710@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
Message-ID: <alpine.LFD.2.00.1005252025210.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 May 2010, apatard at mandriva.com wrote:

> This patch enables support for the i2s controller available on orion/kirkwood platforms
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

The actual Orion processor family has no I2S/audio support.  It would be 
better if all the audio related stuff was renamed to "kirkwood" and 
"KIRKWOOD_*" instead.

> Index: sound-2.6/sound/soc/orion/Kconfig
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ sound-2.6/sound/soc/orion/Kconfig	2010-05-25 10:31:24.601080937 +0200
> @@ -0,0 +1,11 @@
> +config SND_ORION_SOC
> +	tristate "SoC Audio for the Marvell Orion/Kirkwood chip"
> +	depends on ARCH_KIRKWOOD || ARCH_ARCH_ORION5X

ARCH_ARCH_ORION5X should probably be ARCH_ORION5X.  But again, this is 
wrong to add ARCH_ORION5X anyway.


Nicolas
