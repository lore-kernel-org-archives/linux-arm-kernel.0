From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 12 Dec 2013 11:46:21 +0900
Subject: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
In-Reply-To: <1386757818-5154-1-git-send-email-marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
Message-ID: <002a01cef6e4$57583ce0$0608b6a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 11, 2013 7:30 PM, Marek Vasut wrote:
> 
> Some boards do not have a PCIe reset GPIO. To avoid probe
> failure on these boards, make the reset GPIO optional as
> well.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Harro Haan <hrhaan@gmail.com>
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
> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
>  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index d5d26d4..b7a2279 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -19,9 +19,9 @@ Required properties:
>  	to define the mapping of the PCIe interface to interrupt
>  	numbers.
>  - num-lanes: number of lanes to use
> -- reset-gpio: gpio pin number of power good signal
> 
>  Optional properties for fsl,imx6q-pcie
> +- reset-gpio: gpio pin number of power good signal

(+cc Kishon Vijay Abraham I)

As I said earlier,
'reset-gpio' property can be used for 'samsung,exynos5440-pcie'.
Thus, it is not specific for 'fsl,imx6q-pcie'.

Please, modify it as below:

--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -19,6 +19,8 @@ Required properties:
        to define the mapping of the PCIe interface to interrupt
        numbers.
 - num-lanes: number of lanes to use
+
+Optional properties
 - reset-gpio: gpio pin number of power good signal

 Optional properties for fsl,imx6q-pcie

Best regards,
Jingoo Han
