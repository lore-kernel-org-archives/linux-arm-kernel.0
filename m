From: nm@ti.com (Nishanth Menon)
Date: Wed, 9 Oct 2013 08:14:40 -0500
Subject: [PATCH v2 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd
 support
In-Reply-To: <1381163104-6318-1-git-send-email-balajitk@ti.com>
References: <1381163104-6318-1-git-send-email-balajitk@ti.com>
Message-ID: <525556C0.1060100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 11:25 AM, Balaji T K wrote:
> Add mmc1 dt node to dra7-evm board.
> Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
> on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
> will be modelled as cascaded regulator.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> Rebase to for_3.13/dts
> 
>  arch/arm/boot/dts/dra7-evm.dts |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index fbbe406..65cd15a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -250,3 +250,9 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart3_pins>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&ldo1_reg>;
> +	bus-width = <4>;
> +};
> 
boot tested on DRA7-EVM
voltage rail is correct based on schematics(rev d1) too
(LDO1->MMC1_3V3->SDcard).

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
