From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 11:44:26 +0200
Subject: [PATCH v8 10/17] ARM: dts: sun6i: Add mmc clocks
In-Reply-To: <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-11-git-send-email-hdegoede@redhat.com>
Message-ID: <20140423094426.GK24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 01:01:30PM +0200, Hans de Goede wrote:
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

This is simply not true.

module0 clocks don't have any kind of phase control, while we do here.

You should introduce a new compatible.

(and change the clock-names content accordingly)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/b770600c/attachment.sig>
