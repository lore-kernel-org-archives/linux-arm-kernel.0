From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Dec 2013 16:25:52 +0100
Subject: [PATCH v2 2/4] ARM: dts: sun7i: external clock outputs
In-Reply-To: <1388373949-28506-3-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
 <1388373949-28506-3-git-send-email-wens@csie.org>
Message-ID: <20131230152552.GU3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 30, 2013 at 11:25:47AM +0800, Chen-Yu Tsai wrote:
> This commit adds the two external clock outputs available on A20 to
> its device tree. A dummy fixed factor clock is also added to serve as
> the first input of the clock outputs, which according to AW's A20 user
> manual, is the 24MHz oscillator divided by 750.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 4c25f81..f255a49 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -302,6 +302,33 @@
>  			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
>  			clock-output-names = "mbus";
>  		};
> +
> +		/*
> +		 * Dummy clock used by output clocks
> +		 */
> +		osc24M_32k: osc24M_32k {

the node name should be clk to reflect the function of the device, and
not what instance of it it might be.

You should probably use something like clk at 0, to avoid collisions with
other dummy clocks.

Note that we have pretty much the same problem already for the losc
and osc24M, it would be great if you could do a patch for these too :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/409a4777/attachment.sig>
