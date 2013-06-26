From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jun 2013 17:58:46 +0200
Subject: [PATCHv2 3/3] ARM: mxs: dt: Add Crystalfontz CFA-10058 device tree
In-Reply-To: <1372261232-21051-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372261232-21051-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372261232-21051-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20130626155846.GH5803@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, Jun 26, 2013 at 05:40:32PM +0200, Alexandre Belloni wrote:
> From: Brian Lilly <brian@crystalfontz.com>
> 
> The CFA-10057 is a breakout board for the CFA-10036 that has Ethernet, USB and a
> 5" LCD screen on it.
> 
> Signed-off-by: Brian Lilly <brian@crystalfontz.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx28-cfa10058.dts | 158 +++++++++++++++++++++++++++++++++++
>  2 files changed, 159 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-cfa10058.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d494f37..ddd6f32 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -133,6 +133,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx28-cfa10055.dtb \
>  	imx28-cfa10056.dtb \
>  	imx28-cfa10057.dtb \
> +	imx28-cfa10058.dtb \
>  	imx28-evk.dtb \
>  	imx28-m28evk.dtb \
>  	imx28-sps1.dtb \
> diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
> new file mode 100644
> index 0000000..99a21ac
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-cfa10058.dts
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright 2013 Crystalfontz America, Inc.
> + * Copyright 2013 Free Electrons
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/*
> + * The CFA-10058 is an expansion board for the CFA-10036 module, thus we
> + * need to include the CFA-10036 DTS.
> + */
> +/include/ "imx28-cfa10036.dts"
> +
> +/ {
> +	model = "Crystalfontz CFA-10058 Board";
> +	compatible = "crystalfontz,cfa10058", "crystalfontz,cfa10036", "fsl,imx28";
> +
> +	apb at 80000000 {
> +		apbh at 80000000 {
> +			pinctrl at 80018000 {
> +				pinctrl-names = "default", "default";
> +				pinctrl-1 = <&hog_pins_cfa10058
> +					&hog_pins_cfa10058_pullup>;

It doesn't compile, this node doesn't exist anymore.

> +				hog_pins_cfa10058: hog-10058 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x0073 /* MX28_PAD_GPMI_D7__GPIO_0_7 */
> +						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */

Again, we should probably split out these two pins into two different
nodes that would be grabed by their respective drivers.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/6defb639/attachment-0001.sig>
