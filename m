From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 10 Mar 2014 15:28:35 +0200
Subject: [PATCH v2 1/8] ARM: dts: dra7: Initialize USB_DPLL
In-Reply-To: <1394455761-19226-1-git-send-email-rogerq@ti.com>
References: <1394197751-28984-2-git-send-email-rogerq@ti.com>
 <1394455761-19226-1-git-send-email-rogerq@ti.com>
Message-ID: <531DBE03.2070603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2014 02:49 PM, Roger Quadros wrote:
> USB_DPLL must be initialized and locked at boot so that
> USB modules can work.
>
> Program USB_DLL_M2 output to half rate as well.
>
> Patch depends on
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg101300.html
>
> CC: Mike Turquette <mturquette@linaro.org>
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 597979b..f376923 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -815,3 +815,11 @@
>   };
>
>   /include/ "dra7xx-clocks.dtsi"
> +
> +&dpll_usb_ck {
> +        default-rate = <960000000>;
> +};
> +
> +&dpll_usb_m2_ck {
> +	default-rate = <480000000>;
> +};
>

You can add these directly under the dra7xx-clocks.dtsi file as well, as 
I don't think anybody needs to modify these. And the properties can be 
added directly under the nodes themselves.

However, this patch can't be acked yet as we have no feedback from Mike 
for the default-rate proposal.

-Tero
