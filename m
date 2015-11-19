From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Nov 2015 21:47:05 +0100
Subject: [PATCH RESEND 1/8] arm: dts: berlin2q: add watchdog nodes
In-Reply-To: <1447672194-483-2-git-send-email-jszhang@marvell.com>
References: <1447672194-483-1-git-send-email-jszhang@marvell.com>
 <1447672194-483-2-git-send-email-jszhang@marvell.com>
Message-ID: <564E3549.2050700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.11.2015 12:09, Jisheng Zhang wrote:
> The Marvell Berlin BG2Q has 3 watchdogs which are compatible with the
> snps,dw-wdt driver sit in the sysmgr domain. This patch adds the
> corresponding device tree nodes.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index a3ecde5..fac4315 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -483,6 +483,30 @@
>  			ranges = <0 0xfc0000 0x10000>;
>  			interrupt-parent = <&sic>;
>  
> +			wdt0: watchdog at 1000 {
> +				compatible = "snps,dw-wdt";
> +				reg = <0x1000 0x100>;
> +				clocks = <&refclk>;
> +				interrupts = <0>;
> +				status = "disabled";

Jisheng,

as the watchdogs are internal and cannot be clock gated
at all, how about we remove the status = "disabled" and
make them always available?

I have applied patches 1-4 with the status property removed.
This also renders patches 5-8 useless.

So, for now tentatively

Appled to berlin/dt and berlin64/dt respectivly

with status property removed.

Sebastian
