From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 14:33:48 +0800
Subject: [RESEND][PATCH 6/6] arm64: Add DTS support for FSL's LS2088A SoC
In-Reply-To: <1478597664-14799-7-git-send-email-abhimanyu.saini@nxp.com>
References: <1478597664-14799-1-git-send-email-abhimanyu.saini@nxp.com>
 <1478597664-14799-7-git-send-email-abhimanyu.saini@nxp.com>
Message-ID: <20161114063346.GH3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 03:04:24PM +0530, Abhimanyu Saini wrote:
> This patch adds the device tree support for FSL LS2088A SoC based on
> ARMv8 architecture.
> 
> Following levels of DTSI/DTS files have been created for the LS2088A
> SoC family:
> 
>      - fsl-ls2088a.dtsi:
>             DTS-Include file for FSL LS2088A SoC.
> 
>      - fsl-ls2088a-qds.dts:
>             DTS file for FSL LS2088A QDS board.
> 
>      - fsl-ls2088a-rdb.dts:
>             DTS file for FSL LS2088A RDB board.

I compared the following files.

 fsl-ls2088a.dtsi vs. fsl-ls2080a.dtsi
 fsl-ls2088a-qds.dtsi vs. fsl-ls2080a-qds.dtsi
 fsl-ls2088a-rdb.dtsi vs. fsl-ls2080a-rdb.dtsi

They are basically identical except a couple of small changes.  Can we
do something to have these SoCs share the dts files at some level to
avoid maintaining duplicated files?

Shawn 

> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   2 +
>  arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts | 211 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts | 166 +++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi    | 703 ++++++++++++++++++++++
>  4 files changed, 1082 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
