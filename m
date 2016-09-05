From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Sep 2016 10:25:38 +0800
Subject: [PATCH v4 1/2] nxp/dts: add pcie aer interrupt-name property in
 the dts
In-Reply-To: <1472625442-23309-1-git-send-email-po.liu@nxp.com>
References: <1465892645-32381-2-git-send-email-po.liu@nxp.com>
 <1472625442-23309-1-git-send-email-po.liu@nxp.com>
Message-ID: <20160905022537.GF25778@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 02:37:21PM +0800, Po Liu wrote:
> NXP some platforms aer interrupt was not MSI/MSI-X/INTx
> but using interrupt line independently. This patch add a "aer"
> interrupt-names for aer interrupt.
> With the interrupt-names "aer", code could probe aer interrupt
> line for pcie root port, replace the aer interrupt service irq.
> This is intend to fixup the Layerscape platforms which aer interrupt
> was not MSI/MSI-X/INTx, but using interrupt line independently.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
> changes for V4:
> 	- Add comments explain why to add this patch
> 	- Move the binding changes to pci code patch
> 
>  arch/arm/boot/dts/ls1021a.dtsi                 |  6 ++++--
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 18 +++++++++---------
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 16 ++++++++--------

Do not mix up arm dts changes with arm64 ones.  Use separate patch
please.

Shawn
