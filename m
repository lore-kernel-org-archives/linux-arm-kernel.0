From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 May 2015 14:57:31 -0700
Subject: [PATCH v2 2/3] clk: meson: Document bindings for Meson8b clock
 controller
In-Reply-To: <1431773333-23567-3-git-send-email-carlo@caione.org>
References: <1431773333-23567-1-git-send-email-carlo@caione.org>
 <1431773333-23567-3-git-send-email-carlo@caione.org>
Message-ID: <20150528215731.GD24204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Add documentation for  the clock controller.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../bindings/clock/amlogic,meson8b-clkc.txt        | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> new file mode 100644
> index 0000000..2b7b3fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> @@ -0,0 +1,40 @@
> +* Amlogic Meson8b Clock and Reset Unit
> +
> +The Amlogic Meson8b clock controller generates and supplies clock to various
> +controllers within the SoC.
> +
> +Required Properties:
> +
> +- compatible: should be "amlogic,meson8b-clkc"
> +- reg: it must be composed by two tuples:
> +	0) physical base address of the xtal register and length of memory
> +	   mapped region.
> +	1) physical base address of the clock controller and length of memory
> +	   mapped region.
> +
> +- #clock-cells: should be 1.
> +
> +Each clock is assigned an identifier and client nodes can use this identifier
> +to specify the clock which they consume. All available clocks are defined as
> +preprocessor macros in the dt-bindings/clock/meson8b-clkc.h header and can be
> +used in device tree sources.
> +
> +Example: Clock controller node:
> +
> +	clkc: clock-controller at c1104000 {

The address after the '@' should be the first reg property.

> +		#clock-cells = <1>;
> +		compatible = "amlogic,meson8b-clkc";
> +		reg = <0xc1108000 0x4>, <0xc1104000 0x460>;

And a reg property of length 0x4 looks like it may be part of
some other "device". Should the xtal register be part of a syscon
that this node has a phandle to?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
