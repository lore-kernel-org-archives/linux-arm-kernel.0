From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 19 May 2014 11:48:15 +0200
Subject: [PATCH v5 2/2] ARM: dts: mx51: Remove mach-cpuimx51sd board file
In-Reply-To: <20140513015431.GI8330@dragon>
References: <1399736856-9489-1-git-send-email-festevam@gmail.com>
 <1399736856-9489-2-git-send-email-festevam@gmail.com>
 <20140513015431.GI8330@dragon>
Message-ID: <1400492895.2007.7.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-05-13 at 09:54 +0800, Shawn Guo wrote:
> On Sat, May 10, 2014 at 12:47:36PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > eukrea_mbimxsd51-baseboard.c and mach-cpuimx51sd.c can be replaced with their
> > devicetree equivalents: imx51-eukrea-mbimxsd51-baseboard.dts and 
> > imx51-eukrea-cpuimx51.dtsi respectively, so remove the board files.
> > 
> > This allows the conversion of mx51 to a devicetree-only platform.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This is not a dts patch, so I dropped 'dts' from patch prefix.
> 
> Applied both, thanks.

This patch just hit linux-next (in next-20140519) as "ARM: mx51: Remove
mach-cpuimx51sd board file".

It removed the Kconfig symbol MACH_EUKREA_MBIMXSD51_BASEBOARD. But it
left one reference to that symbol in sound/soc/fsl/Kconfig untouched,
see:

config SND_SOC_EUKREA_TLV320
	tristate "Eukrea TLV320"
	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
		|| MACH_EUKREA_MBIMXSD51_BASEBOARD \
		|| (OF && ARM)
	depends on I2C
	select SND_SOC_TLV320AIC23_I2C
	select SND_SOC_IMX_AUDMUX
	select SND_SOC_IMX_SSI
	select SND_SOC_FSL_SSI
	select SND_SOC_IMX_PCM_DMA
	help
	  Enable I2S based access to the TLV320AIC23B codec attached
	  to the SSI interface

What should be done with that last reference?


Paul Bolle
