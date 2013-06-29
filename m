From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 29 Jun 2013 09:13:33 +0200
Subject: [PATCHv3 2/8] ARM: mxs: dt: Add Crystalfontz CFA-10056 device tree
In-Reply-To: <1372424577-8279-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1372424577-8279-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372424577-8279-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20130629071333.GH2593@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 03:02:51PM +0200, Alexandre Belloni wrote:
> From: Brian Lilly <brian@crystalfontz.com>
> 
> The CFA-10056 is a breakout board for the CFA-10036, and is
> basically a CFA-10037, with a 4.3" screen.
> 
> Signed-off-by: Brian Lilly <brian@crystalfontz.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx28-cfa10056.dts | 120 +++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-cfa10056.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..da75139 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx28-cfa10037.dtb \
>  	imx28-cfa10049.dtb \
>  	imx28-cfa10055.dtb \
> +	imx28-cfa10056.dtb \
>  	imx28-cfa10057.dtb \
>  	imx28-evk.dtb \
>  	imx28-m28evk.dtb \
> diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
> new file mode 100644
> index 0000000..0f66c40
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-cfa10056.dts
> @@ -0,0 +1,120 @@
> +/*
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
> + * The CFA-10056 is an expansion board for the CFA-10036 module, thus we
> + * need to include the CFA-10036 DTS.
> + */
> +/include/ "imx28-cfa10037.dts"

The comment is wrong here. You say that you need to include the 10036
DTS, while you actually include the 10037 one.

> +
> +/ {
> +	model = "Crystalfontz CFA-10056 Board";
> +	compatible = "crystalfontz,cfa10056", "crystalfontz,cfa10036", "fsl,imx28";

Adding the cfa10037 compatible here would probably make sense as well.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130629/e3cfd433/attachment.sig>
