From: timur@freescale.com (Timur Tabi)
Date: Wed, 7 Mar 2012 14:20:29 -0600
Subject: [PATCH v2 09/17] ASoC: fsl: separate SSI and DMA Kconfig options
In-Reply-To: <1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F57C30D.3000101@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> The fsl_ssi driver will possibly be shared between Freescale PowerPC
> and ARM/IMX families, so give it a separate Kconfig option.  Then
> fsl_ssi driver can possibly be selected independently from selecting
> PowerPC DMA based PCM driver.

This patch is going to require an update to the defconfigs, because by
default, it sets audio as disabled.

menuconfig SND_POWERPC_SOC
	tristate "SoC Audio for Freescale PowerPC CPUs"
	depends on FSL_SOC
	help
	  Say Y or M if you want to add support for codecs attached to
	  the PowerPC CPUs.

The P1022DS uses mpc85xx_smp_defconfig and mpc85xx_defconfig.  The
MPC8610HPCD uses mpc8610_hpcd_defconfig.

-- 
Timur Tabi
Linux kernel developer at Freescale
