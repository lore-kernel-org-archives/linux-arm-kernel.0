From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Jul 2014 16:34:25 +0100
Subject: [PATCH v3 2/3] usb: dwc3: dwc3-st: Add st-dwc3 devicetree
 bindings documentation
In-Reply-To: <1406126915-30601-3-git-send-email-peter.griffin@linaro.org>
References: <1406126915-30601-1-git-send-email-peter.griffin@linaro.org>
 <1406126915-30601-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20140723153425.GL23210@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Jul 2014, Peter Griffin wrote:

> This patch documents the device tree documentation required for
> the ST usb3 controller glue layer found in STiH407 devices.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3-st.txt | 69 +++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
> new file mode 100644
> index 0000000..de3fea3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
> @@ -0,0 +1,69 @@
> +ST DWC3 glue logic
> +
> +This file documents the parameters for the dwc3-st driver.
> +This driver controls the glue logic used to configure the dwc3 core on
> +STiH407 based platforms.
> +
> +Required properties:
> + - compatible	: must be "st,stih407-dwc3"

Does this only exist for Cannes?

> + - reg		: glue logic base address and USB syscfg ctrl register offset
> + - reg-names	: should be "reg-glue" and "syscfg-reg"
> + - st,syscon	: should be phandle to system configuration node which
> +		  encompasses the glue registers

This should be st,syscfg.  As you have it in the example.

Besides this small issue, I don't see anything controversial so once
fixed up, you can apply my:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
