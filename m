From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 16 Jun 2014 13:24:45 +0200
Subject: [PATCH] ARM: dts: berlin2q.dtsi: set L2CC tag and data latency
 as 2 cycles
In-Reply-To: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
References: <1402565920-5636-1-git-send-email-jszhang@marvell.com>
Message-ID: <539ED3FD.1090201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2014 11:38 AM, Jisheng Zhang wrote:
> For all BG2Q SoCs, 2 cycles is the best/correct value
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin/dt with following fixed patch title:
   "ARM: dts: berlin2q: set L2CC tag and data latency to 2 cycles"

Thanks!

> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 635a16a..3f95dc5 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -90,6 +90,8 @@
>   			compatible = "arm,pl310-cache";
>   			reg = <0xac0000 0x1000>;
>   			cache-level = <2>;
> +			arm,data-latency = <2 2 2>;
> +			arm,tag-latency = <2 2 2>;
>   		};
>
>   		scu: snoop-control-unit at ad0000 {
>
