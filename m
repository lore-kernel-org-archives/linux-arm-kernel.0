From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Oct 2015 19:47:12 -0500
Subject: [PATCH v2 3/4] ARM: dts: DRA7: Add timer12 node
In-Reply-To: <1444087704-1429-4-git-send-email-s-anna@ti.com>
References: <1444087704-1429-1-git-send-email-s-anna@ti.com>
 <1444087704-1429-4-git-send-email-s-anna@ti.com>
Message-ID: <87y4fgesbz.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suman Anna <s-anna@ti.com> writes:

> Add the DT node for Timer12 present on DRA7 family of
> SoCs. Timer12 is present in PD_WKUPAON power domain, and
> has the same capabilities as the other timers, except for
> the fact that it serves as a secure timer on HS devices
> and is clocked only from the secure 32K clock.
>
> The node is marked disabled for now, and the kernel should
> refrain from using this secure timer on HS devices.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index e289c706d27d..37d632dad576 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -762,6 +762,16 @@
>  			ti,hwmods = "timer11";
>  		};
>  
> +		timer12: timer at 4ae20000 {
> +			compatible = "ti,omap5430-timer";
> +			reg = <0x4ae20000 0x80>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "timer12";
> +			ti,timer-alwon;
> +			ti,timer-secure;
> +			status = "disabled";

according to Tony we should avoid using status at all for in-SoC
devices.

Tony, can you confirm I understood you correctly ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/72a82d63/attachment.sig>
