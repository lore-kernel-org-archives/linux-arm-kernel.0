From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 14:43:03 +0200
Subject: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
In-Reply-To: <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <CACRpkdZ-xnDO+bte4tyKDWwY4A_qWUhLru3dUmuY9MQwseP3uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:26 AM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> The STiH415 is the next generation of HD, AVC set-top box processors for
> satellite, cable, terrestrial and IP-STB markets. It is an ARM Cortex-A9
> 1.0 GHz, dual-core CPU.
(...)
> +       soc {
> +               pin-controller-sbc {
> +                       #address-cells  = <1>;
> +                       #size-cells     = <1>;
> +                       compatible      = "st,stih415-pinctrl", "simple-bus";

Why is the pin controller be a simple bus?

Maybe obvious, I'm not 100% familiar with when we use this...

> +               pin-controller-front {
(...)
> +               pin-controller-rear {
(...)
> +               pin-controller-left {
(...)
> +               pin-controller-right {

Please explain these orientations in some comment in the device
tree, I'm half-guessing that it's about the edges around the chip so
the PIO* names are actually pad names.

I would suggest you use the names north/south/west/east
if this is the case since left and right etc are relative measures.
(This terminology is used on e.g. dance mats for console games...)

If these names are from the datasheets by all means keep them.

> +++ b/arch/arm/boot/dts/stixxxx-pincfg.h
> @@ -0,0 +1,94 @@
> +#ifndef _STIXXXX_PINCFG_H_
> +#define _STIXXXX_PINCFG_H_
> +
> +/* Alternate functions */
> +#define ALT1   1
> +#define ALT2   2
> +#define ALT3   3
> +#define ALT4   4
> +#define ALT5   5
> +#define ALT6   6
> +#define ALT7   7

Why is this part of the DT definitions? In the pinctrl world this
is an intrinsic detail on how groups and functions are associated,
not something that you hard-code into the device tree. The
device tree should state how to combine functions with groups
and those will be strings, not numerals.

Yours,
Linus Walleij
