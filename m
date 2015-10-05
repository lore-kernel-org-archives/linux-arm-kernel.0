From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 05 Oct 2015 20:19:53 +0200
Subject: [PATCH v7 3/5] ARM: berlin: add a PWM node on the BG2Q
In-Reply-To: <1443797990-10809-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
 <1443797990-10809-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5612BF49.6020607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.10.2015 16:59, Antoine Tenart wrote:
> This patch adds a PWM node in the Berlin BG2Q device tree, using the
> newly added Berlin PWM driver.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)

Applied this and the next two for BG2 and BG2CD
to berlin/dt.

Thanks,
   Sebastian

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 63a48490e2f9..5bfa71a87617 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -477,6 +477,13 @@
>   			status = "disabled";
>   		};
>
> +		pwm: pwm at f20000 {
> +			compatible = "marvell,berlin-pwm";
> +			reg = <0xf20000 0x40>;
> +			clocks = <&chip_clk CLKID_CFG>;
> +			#pwm-cells = <3>;
> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>
