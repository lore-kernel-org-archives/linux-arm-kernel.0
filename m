From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Jan 2013 09:07:48 +0800
Subject: [PATCH] ARM: imx: Do not select some errata that depends on
 !ARCH_MULTIPLATFORM
In-Reply-To: <50E76795.2000201@gmail.com>
References: <1357338447-6798-1-git-send-email-festevam@gmail.com>
 <50E76795.2000201@gmail.com>
Message-ID: <20130105010743.GG1887@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 04, 2013 at 05:36:53PM -0600, Rob Herring wrote:
> On 01/04/2013 04:27 PM, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Since commit 62e4d357a (ARM: 7609/1: disable errata work-arounds which access 
> > secure registers) ARM_ERRATA_743622/751472 depends on !ARCH_MULTIPLATFORM.
> > 
> > Since imx has been converted to multiplatform, the following warning happens:
> > 
> > $ make imx_v6_v7_defconfig
> > warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> > ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
> > !ARCH_MULTIPLATFORM)
> > warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
> > which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
> > warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
> > which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
> > warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
> > ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
> > !ARCH_MULTIPLATFORM)
> > 
> > Recommended approach is to remove ARM_ERRATA_743622/751472 from being selected
> > by SOC_IMX6Q and apply such workarounds into the bootloader.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Broken and
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
I think the patch should be put into Russell's the patch system to
have it go through the same branch that 7609/1 goes.

Shawn
