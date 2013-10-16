From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 16 Oct 2013 10:24:56 +0900
Subject: [PATCH 1/6] PCI: imx6: Make reset-gpio optional
In-Reply-To: <1381853200-5534-2-git-send-email-marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-2-git-send-email-marex@denx.de>
Message-ID: <006401ceca0e$86427be0$92c773a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 16, 2013 1:07 AM, Marek Vasut wrote:
> 
> Some boards do not have a PCIe reset GPIO. To avoid probe
> failure on these boards, make the reset GPIO optional as
> well.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

[.....]

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
>  - power-on-gpio: gpio pin number of power-enable signal
>  - wake-up-gpio: gpio pin number of incoming wakeup signal
>  - disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal

(+cc Kishon Vijay Abraham I)

Also, 'reset-gpio' property can be used for 'samsung,exynos5440-pcie'.
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
