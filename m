From: madalin.bucur@nxp.com (Madalin-Cristian Bucur)
Date: Wed, 17 May 2017 11:03:20 +0000
Subject: [PATCH 2/3] arm64: dts: add LS1043A DPAA FMan support
In-Reply-To: <201705171805.DxANFDT3%fengguang.wu@intel.com>
References: <1494936443-14869-3-git-send-email-madalin.bucur@nxp.com>
 <201705171805.DxANFDT3%fengguang.wu@intel.com>
Message-ID: <AM5PR0402MB2691847B7DAA3C3B4A609A9BECE70@AM5PR0402MB2691.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Shawn,

The patch that failed depends on a patch set that should be in Shawn's tree:

	-----Original Message-----
	From: Shawn Guo [mailto:shawnguo at kernel.org] 
	Sent: Tuesday, May 16, 2017 4:40 AM
	To: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
	Cc: mark.rutland at arm.com; devicetree at vger.kernel.org; catalin.marinas at arm.com; will.deacon at arm.com; linux-	kernel at vger.kernel.org; robh+dt at kernel.org; linux-arm-kernel at lists.infradead.org
	Subject: Re: [PATCH v2 0/3] arm64: dts: introduce QorIQ DPAA 1.x QBMan device tree nodes

	On Mon, May 15, 2017 at 12:21:15PM +0300, Madalin Bucur wrote:
	> Madalin Bucur (3):
	>   arm64: dts: add DPAA QBMan portals
	>   arm64: dts: add LS1043A DPAA QBMan nodes
	>   arm64: dts: add LS1046A DPAA QBMan nodes

	Applied all, thanks.

Crash is related to the use of GIC_SPI and IRQ_TYPE_LEVEL_HIGH that require the
header included in the above patches (<dt-bindings/interrupt-controller/arm-gic.h>).

Madalin

> -----Original Message-----
> From: kbuild test robot [mailto:lkp at intel.com]
> Sent: Wednesday, May 17, 2017 1:42 PM
> To: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
> Cc: kbuild-all at 01.org; shawnguo at kernel.org; devicetree at vger.kernel.org;
> mark.rutland at arm.com; robh+dt at kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> catalin.marinas at arm.com; will.deacon at arm.com; Madalin-Cristian Bucur
> <madalin.bucur@nxp.com>
> Subject: Re: [PATCH 2/3] arm64: dts: add LS1043A DPAA FMan support
> 
> Hi Madalin,
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on v4.12-rc1 next-20170517]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Madalin-Bucur/arm64-dts-
> add-DPAA-FMan-nodes/20170517-103731
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> for-next
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
> 
> All errors (new ones prefixed by >>):
> 
> >> Error: arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi:16.16-17 syntax
> error
>    FATAL ERROR: Unable to parse input tree
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
