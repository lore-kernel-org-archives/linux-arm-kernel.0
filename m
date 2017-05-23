From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 10:14:08 -0500
Subject: [PATCH v2 2/5] dt-bindings: display: Add Synopsys DW MIPI DSI
 DRM bridge driver
In-Reply-To: <1495207218-11372-3-git-send-email-philippe.cornu@st.com>
References: <1495207218-11372-1-git-send-email-philippe.cornu@st.com>
 <1495207218-11372-3-git-send-email-philippe.cornu@st.com>
Message-ID: <20170523151408.jn3vlqh5i4xmmtqw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 05:20:15PM +0200, Philippe CORNU wrote:
> This patch adds documentation of device tree bindings for the
> Synopsys DesignWare MIPI DSI host DRM bridge driver.
> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> ---
>  .../bindings/display/bridge/dw_mipi_dsi.txt        | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> new file mode 100644
> index 0000000..652c0f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> @@ -0,0 +1,36 @@
> +Synopsys DesignWare MIPI DSI host controller
> +============================================
> +
> +This document defines device tree properties for the Synopsys DesignWare MIPI
> +DSI host controller. It doesn't constitue a device tree binding specification
> +by itself but is meant to be referenced by platform-specific device tree
> +bindings.
> +
> +When referenced from platform device tree bindings the properties defined in
> +this document are defined as follows. The platform device tree bindings are
> +responsible for defining whether each property is required or optional.
> +
> +- reg: Memory mapped base address and length of the DWC MIPI DSI registers.
> +
> +- clocks: References to all the clocks specified in the clock-names property
> +  as specified in [1].
> +
> +- clock-names: The DWC MIPI DSI host uses the following clocks.
> +
> +  - "pclk" is the peripheral clock for either AHB and APB (mandatory).
> +  - "ref" is the pll reference clock (mandatory).
> +
> +- resets: References to all the resets specified in the reset-names property
> +  as specified in [2]. (optional)
> +
> +- reset-names: string reset name, must be "apb" if used. (optional)
> +
> +- ports: The connectivity of the DWC MIPI DSI host controller
> +  with the rest of the system is expressed in using ports as specified in the
> +  device graph bindings in [3] & [4]. The numbering of the ports
> +  is platform-specific.

Why is numbering platform specific? Are there differing numbers of 
independent channels? I'm fine if platforms can override, but can we 
define what is the default or common case?

> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +[2] Documentation/devicetree/bindings/reset/reset.txt
> +[3] Documentation/devicetree/bindings/media/video-interfaces.txt
> +[4] Documentation/devicetree/bindings/graph.txt
> -- 
> 1.9.1
> 
