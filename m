From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 13:55:53 +0800
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <4F748C8E.1010702@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
 <4F748C8E.1010702@freescale.com>
Message-ID: <20120330055543.GH19506@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:23:42AM -0500, Timur Tabi wrote:
> Shawn Guo wrote:
> > d18b63ab0b04af1bad01e59a96b88fc8cda08752
> > ASoC: core: Use driver core probe deferral
> 
> That fixed it, but the SHA in my repository is
> 97883ef0a8f61fbd5fb8242980f6998290d1dd95
> 
> Anyway, I just want to say that for-3.5 still works on PowerPC.
> 
I guess you only meant mpc85xx_defconfig (and mpc85xx_smp_defconfig).
I sent the patch after compile-testing for mpc85xx_defconfig, and
took it for granted that mpc8610_hpcd_defconfig will also compile.
But I just discovered that PPC_CLOCK is not enabled for
mpc8610_hpcd_defconfig, so it fails on the final link.

I just sent a patch proposing to fix it by always building in PPC_CLOCK
for FSL_SOC.

-- 
Regards,
Shawn
