From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 14:30:58 +0100
Subject: [PATCH v6 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <1394890861-18347-3-git-send-email-carlo@caione.org>
References: <1394890861-18347-1-git-send-email-carlo@caione.org>
 <1394890861-18347-3-git-send-email-carlo@caione.org>
Message-ID: <20140317133057.GK27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 02:41:00PM +0100, Carlo Caione wrote:
> This patch adds DTS entries for NMI controller as child of GIC.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 9 +++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 5256ad9..4a5050c 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -190,6 +190,15 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		nmi_intc: sc-nmi-intc at 01f00c0c {

It should be interrupt-controller at 01f00c0c, according to the ePAPR.

> +			compatible = "allwinner,sun6i-a31-sc-nmi";

I'm curious, what is the "sc" for?

> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x01f00c0c 0x38>;
> +			interrupt-parent = <&gic>;

This is actually the default.

> +			interrupts = <0 0 4>;
> +		};
> +

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/aab143b9/attachment.sig>
