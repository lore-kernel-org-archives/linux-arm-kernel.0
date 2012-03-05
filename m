From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 14:45:35 -0800
Subject: [PATCH 1/3] arm: anticipate build breakages due in pending merge
In-Reply-To: <1330987310-8108-2-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
 <1330987310-8108-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120305224534.GG12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Gortmaker <paul.gortmaker@windriver.com> [120305 14:10]:
> Testing in linux-next has revealed that the omap2plus_defconfig
> will fail upon the merge of "arm-soc/for-next" as follows:
> 
> arch/arm/mach-omap2/control.c:238: error: 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
> arch/arm/mach-omap2/common.c:48: error: 'OMAP2420_SDRC_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/common.c:49: error: 'OMAP2420_SMS_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/common.c:50: error: 'OMAP242X_CTRL_BASE' undeclared here (not in a function)
>  [...]
> arch/arm/mach-omap2/common.c:167: error: 'OMAP4430_CM2_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/sdrc2xxx.c:108: error: 'OMAP2420_PRM_BASE' undeclared (first use in this function)
> arch/arm/mach-omap2/cm2xxx_3xxx.c:310: error: 'OMAP3430_CM_BASE' undeclared (first use in this function)
> 
> It appears that a once implicit path to <plat/hardware.h> has gone
> away once two of the arm streams come together.

Thanks this one is already waiting to be applied to arm-soc
tree.

Regards,

Tony
