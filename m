From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Jan 2018 17:09:40 +0100
Subject: [PATCH] arm64: dts: marvell: armada-80x0: Fix pinctrl compatible
 string
In-Reply-To: <20180112100002.3967-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Fri, 12 Jan 2018 11:00:02 +0100")
References: <20180112100002.3967-1-gregory.clement@free-electrons.com>
Message-ID: <87o9lz5a9n.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On ven., janv. 12 2018, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> When replacing the cpm by cp0 and cps by cp1 [1] not only the label and
> the alias were replaced but also the compatible string which was wrong.
>
> Due to this the pinctrl driver was no more probed.
>
> This patch fix it by reverting this change for the pinctrl compatible
> string on Armada 8K.
>
> [1]: "arm64: dts: marvell: replace cpm by cp0, cps by cp1"
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64 with the reviewed-by flag from Thomas Petazzoni. I
do it right now because I hope being able to make a late pull request
with it in order to have the dtbs in the right state from the beginning
of the 4.16-rc1.

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> index 0d36b0fa7153..e9c84a1d3c4d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -108,13 +108,13 @@
>  
>  &cp0_syscon0 {
>  	cp0_pinctrl: pinctrl {
> -		compatible = "marvell,armada-8k-cp0-pinctrl";
> +		compatible = "marvell,armada-8k-cpm-pinctrl";
>  	};
>  };
>  
>  &cp1_syscon0 {
>  	cp1_pinctrl: pinctrl {
> -		compatible = "marvell,armada-8k-cp1-pinctrl";
> +		compatible = "marvell,armada-8k-cps-pinctrl";
>  
>  		nand_pins: nand-pins {
>  			marvell,pins =
> -- 
> 2.15.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
