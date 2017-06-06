From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 6 Jun 2017 10:00:29 +0200
Subject: [PATCH v3 2/6] dt-bindings: display: Add Synopsys DW MIPI DSI DRM
 bridge driver
In-Reply-To: <1496414235-20098-3-git-send-email-philippe.cornu@st.com>
References: <1496414235-20098-1-git-send-email-philippe.cornu@st.com>
 <1496414235-20098-3-git-send-email-philippe.cornu@st.com>
Message-ID: <c7770778-3132-12f9-1293-f1ced0e3b4e9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2017 04:37 PM, Philippe CORNU wrote:
> This patch adds documentation of device tree bindings for the
> Synopsys DesignWare MIPI DSI host DRM bridge driver.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  .../bindings/display/bridge/dw_mipi_dsi.txt        | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> new file mode 100644
> index 0000000..1d7c438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> @@ -0,0 +1,30 @@
> +Synopsys DesignWare MIPI DSI host controller
> +============================================
> +
> +This document defines device tree properties for the Synopsys DesignWare MIPI
> +DSI host controller. It doesn't constitue a device tree binding specification
---------------------------------------/\

I'm not sure about this one, and it's already here in the dw_hdmi.txt text.


> +by itself but is meant to be referenced by platform-specific device tree
> +bindings.
> +
> +When referenced from platform device tree bindings the properties defined in
> +this document are defined as follows. The platform device tree bindings are
> +responsible for defining whether each property is required or optional.
> +
> +- reg: Memory mapped base address and length of the DWC MIPI DSI
> +  registers. (mandatory)
-------------------/\

Why do you specify the mandatory/optional here since it's written it's the
responsibility of the platform bindings ?

> +
> +- clocks: References to all the clocks specified in the clock-names property
> +  as specified in [1]. (mandatory)
> +
> +- clock-names: "pclk" is peripheral clock for either AHB and APB. (mandatory)
> +
> +- resets: References to all the resets specified in the reset-names property
> +  as specified in [2]. (optional)
> +
> +- reset-names: string reset name, must be "apb" if used. (optional)
> +
> +- panel or bridge node: see [3]. (mandatory)
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/reset/reset.txt
> +[3] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> 
