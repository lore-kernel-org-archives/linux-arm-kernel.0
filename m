From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 7 Dec 2014 16:00:39 +0100
Subject: [PATCH 05/10] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <1417588565-26215-6-git-send-email-wens@csie.org>
References: <1417588565-26215-1-git-send-email-wens@csie.org>
 <1417588565-26215-6-git-send-email-wens@csie.org>
Message-ID: <20141207150039.GE12434@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 03, 2014 at 02:36:00PM +0800, Chen-Yu Tsai wrote:
> Add the device tree nodes for the mmc config clock nodes.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index f3cac3a..f425d9d 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -325,6 +325,19 @@
>  		 */
>  		ranges = <0 0 0 0x20000000>;
>  
> +		mmc_config_clk: clk at 01c23000 {
> +			compatible = "allwinner,sun9i-a80-mmc-clk";
> +			reg = <0x01c13000 0x10>;

The reg and the unit-address don't match.

Also, this used to be defined in the clocks node for the USB case, it
would be good to do the same here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141207/c349f392/attachment.sig>
