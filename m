From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 21:28:16 -0500
Subject: [PATCH v2 22/22] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20160707222114.1673-23-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-23-stephen.boyd@linaro.org>
Message-ID: <20160718022816.GA16357@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:21:13PM -0700, Stephen Boyd wrote:
> The high-speed phy on qcom SoCs is controlled via the ULPI
> viewport.
> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |  83 ++++++
>  drivers/phy/Kconfig                                |   8 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-qcom-usb-hs.c                      | 295 +++++++++++++++++++++
>  4 files changed, 387 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 drivers/phy/phy-qcom-usb-hs.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> new file mode 100644
> index 000000000000..a7bda9186d5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> @@ -0,0 +1,83 @@
> +Qualcomm's USB HS PHY
> +
> +PROPERTIES
> +
> +- compatible:
> +    Usage: required
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-hs-phy"

Add a chip specific compatible.

Rob
