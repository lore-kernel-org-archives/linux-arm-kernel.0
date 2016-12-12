From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Dec 2016 17:35:15 +0000
Subject: [PATCH] ARM: dts: vexpress: Support GICC_DIR operations
In-Reply-To: <20161210201351.25894-1-christoffer.dall@linaro.org>
References: <20161210201351.25894-1-christoffer.dall@linaro.org>
Message-ID: <9d9198a1-ba56-46e5-6226-89eb3825aac3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Sudeep]

On 10/12/16 20:13, Christoffer Dall wrote:
> The GICv2 CPU interface registers span across 8K, not 4K as indicated in
> the DT.  Only the GICC_DIR register is located after the initial 4K
> boundary, leaving a functional system but without support for separately
> EOI'ing and deactivating interrupts.
> 
> After this change the system support split priority drop and interrupt
> deactivation.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index 0205c97..2e0cf39 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -126,7 +126,7 @@
>  		#address-cells = <0>;
>  		interrupt-controller;
>  		reg = <0 0x2c001000 0 0x1000>,
> -		      <0 0x2c002000 0 0x1000>,
> +		      <0 0x2c002000 0 0x2000>,
>  		      <0 0x2c004000 0 0x2000>,
>  		      <0 0x2c006000 0 0x2000>;
>  		interrupts = <1 9 0xf04>;
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
