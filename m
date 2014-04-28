From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:37:53 -0700
Subject: [PATCH v9 10/17] ARM: dts: sun6i: Add mmc clocks
In-Reply-To: <1398507381-5614-11-git-send-email-hdegoede@redhat.com>
References: <1398507381-5614-1-git-send-email-hdegoede@redhat.com>
 <1398507381-5614-11-git-send-email-hdegoede@redhat.com>
Message-ID: <20140428193753.GJ3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 26, 2014 at 12:16:14PM +0200, Hans de Goede wrote:
> Add clk-nodes for the mmc clocks.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index d45efa7..12bcc17 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -198,6 +198,38 @@
>  					"apb2_uart4", "apb2_uart5";
>  		};
>  
> +		mmc0_clk: clk at 01c20088 {
> +			#clock-cells = <0>;
> +			compatible = "allwinner,sun4i-a10-mod0-clk";

And this is not misleading but wrong. The MMC clocks have the phase
control feature that mod0 clock don't have, so they should have a
compatible of their own.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/76115818/attachment.sig>
