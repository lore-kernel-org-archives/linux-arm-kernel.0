From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Mar 2014 17:51:33 +0000
Subject: [PATCH v2 1/5] drivers: input: keyboard: st-keyscan: add
 keyscan driver
In-Reply-To: <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
References: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
 <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140318175133.GE2941@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 03:00:02PM +0000, Gabriel FERNANDEZ wrote:
> This patch adds ST Keyscan driver to use the keypad hw a subset
> of ST boards provide. Specific board setup will be put in the
> given dt.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> ---
>  .../devicetree/bindings/input/st-keyscan.txt       |  60 +++++
>  drivers/input/keyboard/Kconfig                     |  12 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/st-keyscan.c                | 260 +++++++++++++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st-keyscan.txt
>  create mode 100644 drivers/input/keyboard/st-keyscan.c
> 
> diff --git a/Documentation/devicetree/bindings/input/st-keyscan.txt b/Documentation/devicetree/bindings/input/st-keyscan.txt
> new file mode 100644
> index 0000000..51eb428
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/st-keyscan.txt
> @@ -0,0 +1,60 @@
> +* ST Keyscan controller Device Tree bindings
> +
> +The ST keyscan controller Device Tree binding is based on the
> +matrix-keymap.
> +
> +Required properties:
> +- compatible: "st,sti-keyscan"
> +
> +- reg: Register base address and size of st-keyscan controller.
> +
> +- interrupts: Interrupt number for the st-keyscan controller.
> +
> +- clocks: Must contain one entry, for the module clock.
> +  See ../clocks/clock-bindings.txt for details.
> +
> +- pinctrl: Should specify pin control groups used for this controller.
> +  See ../pinctrl/pinctrl-bindings.txt for details.
> +
> +- linux,keymap: The keymap for keys as described in the binding document
> +  devicetree/bindings/input/matrix-keymap.txt.
> +
> +- keypad,num-rows: Number of row lines connected to the keypad controller.
> +
> +- keypad,num-columns: Number of column lines connected to the keypad
> +  controller.
> +
> +Optional property:
> +- st,debounce_us: Debouncing interval time in microseconds

s/_/-/ here, please.

Otherwise this looks ok.

Mark.
