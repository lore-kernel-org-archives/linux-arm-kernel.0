From: timur@freescale.com (Timur Tabi)
Date: Fri, 30 Mar 2012 08:03:28 -0500
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <20120330055543.GH19506@S2101-09.ap.freescale.net>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
 <20120329160916.GG19506@S2101-09.ap.freescale.net>
 <4F748C8E.1010702@freescale.com>
 <20120330055543.GH19506@S2101-09.ap.freescale.net>
Message-ID: <4F75AF20.6080009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> I guess you only meant mpc85xx_defconfig (and mpc85xx_smp_defconfig).
> I sent the patch after compile-testing for mpc85xx_defconfig, and
> took it for granted that mpc8610_hpcd_defconfig will also compile.
> But I just discovered that PPC_CLOCK is not enabled for
> mpc8610_hpcd_defconfig, so it fails on the final link.

Argh.  I was thinking about testing mpc8610 as well, but I thought, "Hey,
p1022ds works, why bother testing the 8610?  Why would it fail?"

> I just sent a patch proposing to fix it by always building in PPC_CLOCK
> for FSL_SOC.

You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
broken, then I don't think he'll like it.

-- 
Timur Tabi
Linux kernel developer at Freescale
