From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 16 Oct 2013 09:03:48 +0900
Subject: [PATCH 0/6] PCI: imx6: Random fixes
In-Reply-To: <1381853200-5534-1-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
Message-ID: <003b01ceca03$309b9ba0$91d2d2e0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Marek Vasut [mailto:marex at denx.de]
> Sent: Wednesday, October 16, 2013 1:07 AM
> To: linux-pci at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Marek Vasut; Bjorn Helgaas; Frank Li; Jingoo Han; Mohit
> KUMAR; Pratyush Anand; Richard Zhu; Sascha Hauer; Sean Cross; Shawn Guo; Siva Reddy Kallam; Srikanth T
> Shivanand; Tim Harvey; Troy Kisky; Yinghai Lu
> Subject: [PATCH 0/6] PCI: imx6: Random fixes
> 
> Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
> setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as expected.
> 
> NOTE: I'm sure this will start some discussion. There are quite a few patches
>       that are more of a hacks. Shawn, I didn't ignore your remark about the
>       clock patches, I will test it ASAP, I just want to have these fixes in
>       the public so others can comment/test.
> 
> Marek Vasut (6):
>   PCI: imx6: Make reset-gpio optional
>   PCI: imx6: Fix the clock for PCIe
>   ARM: dts: imx6qdl: Fix the clock for PCIe
>   PCI: imx6: Probe the PCIe in fs_initcall()
>   PCI: imx6: Force Gen1 operation
>   PCI: designware: Fix DT resource retrieval
> 
>  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +-
>  drivers/pci/host/pci-imx6.c                        | 63 ++++++++++++++++------
>  drivers/pci/host/pcie-designware.c                 | 17 +++---
>  4 files changed, 55 insertions(+), 31 deletions(-)

Hi Marek,

Your patchset modifies Synopsys Designware part. (pcie-designware.c)
Thus, it would be better to share this patchset with Kishon Vijay Abraham I.
He is also developing OMAP PCIe driver using 'pcie-designware.c'.

Best regards,
Jingoo Han

> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> 
> --
> 1.8.4.rc3
