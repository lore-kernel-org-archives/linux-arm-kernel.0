From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 21 May 2014 17:56:25 +0300
Subject: [Patch] ARM: dts: keystone: add pll controller syscon entry
In-Reply-To: <1400681875-24432-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1400681875-24432-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <537CBE99.9090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ignore this. It'll be included in "Introduce keystone reset driver" 
patch series

On 05/21/2014 05:17 PM, Ivan Khoronzhuk wrote:
> The pll controller register set includes sets of registers with
> different purposes, so it's logically to add syscon entry to be able
> to access them from appropriate places.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>
> Based on linux-next/master
>
>   arch/arm/boot/dts/keystone.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index d9f99e7..5e67c5b 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -66,6 +66,11 @@
>   		ranges = <0x0 0x0 0x0 0xc0000000>;
>   		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
>   
> +		pllctrl: pll_controller {
> +			compatible = "ti,keystone-pllctrl", "syscon";
> +			reg = <0x2310000 0x200>;
> +		};
> +
>   		rstctrl: reset-controller {
>   			compatible = "ti,keystone-reset";
>   			reg = <0x023100e8 4>;	/* pll reset control reg */

-- 
Regards,
Ivan Khoronzhuk
