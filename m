From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 8 Mar 2012 21:08:35 +0800
Subject: [PATCH v2 09/17] ASoC: fsl: separate SSI and DMA Kconfig options
In-Reply-To: <4F57C30D.3000101@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
 <4F57C30D.3000101@freescale.com>
Message-ID: <20120308130832.GD2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 02:20:29PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > The fsl_ssi driver will possibly be shared between Freescale PowerPC
> > and ARM/IMX families, so give it a separate Kconfig option.  Then
> > fsl_ssi driver can possibly be selected independently from selecting
> > PowerPC DMA based PCM driver.
> 
> This patch is going to require an update to the defconfigs, because by
> default, it sets audio as disabled.
> 
I guess you meant the next patch (#10) require an update, since
SND_POWERPC_SOC is introduced in that patch.

Regards,
Shawn

> menuconfig SND_POWERPC_SOC
> 	tristate "SoC Audio for Freescale PowerPC CPUs"
> 	depends on FSL_SOC
> 	help
> 	  Say Y or M if you want to add support for codecs attached to
> 	  the PowerPC CPUs.
> 
> The P1022DS uses mpc85xx_smp_defconfig and mpc85xx_defconfig.  The
> MPC8610HPCD uses mpc8610_hpcd_defconfig.
