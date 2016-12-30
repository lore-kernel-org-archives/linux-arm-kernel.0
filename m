From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 19:26:38 +0800
Subject: [PATCH 2/3][v2] arm64: freescale: ls2080a: Split devicetree for
 code resuability
In-Reply-To: <1480325824-14649-3-git-send-email-abhimanyu.saini@nxp.com>
References: <1480325824-14649-1-git-send-email-abhimanyu.saini@nxp.com>
 <1480325824-14649-3-git-send-email-abhimanyu.saini@nxp.com>
Message-ID: <20161230112635.GQ6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 03:07:03PM +0530, Abhimanyu Saini wrote:
> LS2088A and LS2080A are similar SoCs with a few differences like
> ARM cores etc.
> 
> Reorganize the LS2080A device tree to move the common nodes to:
> 	- fsl-ls2080a-ls2088a.dtsi
> 	- fsl-ls2080a-ls2088a-rdb.dts
> 	- fsl-ls2080a-ls2088a-qds.dts

I do not quite like the naming of these files.  Will the following one
be better?

 - fsl-ls208xa.dtsi
 - fsl-ls208xa-rdb.dtsi
 - fsl-ls208xa-qds.dtsi

Also if a DTS file is only to be included by another one, not to
generate a DTB, we name it .dtsi rather than .dts.

Shawn

> 
> Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2080a-ls2088a-qds.dts | 196 ++++++
>  .../boot/dts/freescale/fsl-ls2080a-ls2088a-rdb.dts | 152 +++++
>  .../boot/dts/freescale/fsl-ls2080a-ls2088a.dtsi    | 727 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  | 154 +----
>  arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  | 110 +---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 706 +-------------------
>  6 files changed, 1100 insertions(+), 945 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-ls2088a-qds.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-ls2088a-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2080a-ls2088a.dtsi
