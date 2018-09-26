From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 17:57:54 -0500
Subject: [PATCH v2 1/7] dt-bindings: mfd: Add ST Multi-Function eXpander
 (STMFX) core bindings
In-Reply-To: <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <20180926225754.GA20472@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 03:27:43PM +0200, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) MFD core.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/mfd/stmfx.txt | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stmfx.txt b/Documentation/devicetree/bindings/mfd/stmfx.txt
> new file mode 100644
> index 0000000..21cf798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stmfx.txt
> @@ -0,0 +1,28 @@
> +STMicroelectonics Multi-Function eXpander (STMFX) Core bindings
> +
> +ST Multi-Function eXpander (STMFX) is a slave controller using I2C for
> +communication with the main MCU. Its main features are GPIO expansion, main
> +MCU IDD measurement (IDD is the amount of current that flows through VDD) and
> +resistive touchscreen controller.
> +
> +Required properties:
> +- compatible: should be "st,stmfx-0300".
> +- reg: I2C slave address of the device.
> +- interrupt-parent: phandle of the STMFX parent interrupt controller.

Drop this. It is implied and could be in the parent.

> +- interrutps: interrupt specifier triggered by MFX_IRQ_OUT signal.

typo

> +
> +Optional properties:
> +- drive-open-drain: configure MFX_IRQ_OUT as open drain.
> +- vdd-supply: phandle of the regulator supplying STMFX.
> +
> +Example:
> +
> +	stmfx: stmfx at 42 {
> +		compatible = "st,stmfx-0300";
> +		reg = <0x42>;
> +		interrupts = <8 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-parent = <&gpioi>;
> +		vdd-supply = <&v3v3>;
> +	};
> +
> +Please refer to ../pinctrl/pinctrl-stmfx.txt for STMFX GPIO expander function bindings.
> -- 
> 2.7.4
> 
