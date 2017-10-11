From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 22:54:05 -0700
Subject: [PATCH v2] arm64: qcom: sbc: Name GPIO lines
In-Reply-To: <20171009092844.11451-1-linus.walleij@linaro.org>
References: <20171009092844.11451-1-linus.walleij@linaro.org>
Message-ID: <20171011055405.GI1165@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 09 Oct 02:28 PDT 2017, Linus Walleij wrote:

> This names the GPIO lines on the APQ8016 "SBC" also known
> as the DragonBoard 410c, according to the schematic. This
> is necessary for a conforming userspace looking across
> all GPIO chips for the GPIO lines named "GPIO-A" thru
> "GPIO-L".
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Put the GPIO line names into the .dtsi file for the
>   SBC as requested.
> - Put the GPIO line names into the hierarchical SoC
>   DTS structure as requested.
> - Adjusted legend text to only cover used terminology.
> - Insert proper comments telling which line on the LSEC
>   or HSEC a certain line is routed to.
> 
> I don't have this hardware available, you can test it
> easily by compiling tools/gpio/* and issue "lsgpio" to
> see the GPIO line names in the console.
> ---
>  arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 169 ++++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
[..]
> +				"NC", /* GPIO 70 */
> +				"NC",
> +				"NC",
> +				"NC",
> +				"NC", /* GPIO 74 */

Convenient to know where index 74 is ;P

> +				"NC",
> +				"NC",
> +				"NC",
> +				"NC",
> +				"NC",
> +				"BOOT_CONFIG_0", /* GPIO 80 */

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
