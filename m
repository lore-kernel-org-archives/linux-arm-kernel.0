From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 May 2016 08:21:45 +0100
Subject: PATH[1/3] ARM: axp20x_usb_power.c add device tree configuration
 options for REG 30H: VBUS-IPSOUT
In-Reply-To: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
References: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
Message-ID: <20160518072145.GI17238@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What on earth are all these emails you're sending to the list?

Please read the following documentation to ensure you're using correct
processes to send patches. If you require any help with a particular
aspect, please feel free to ask.

 Documentation/HOWTO 
 Documentation/CodingSytle
 Documentation/email-clients.txt 
 Documentation/SubmittingPatches 

The last one being the most prevalent in this case.

NB: If you use Git to create your patches `git format-patch` and to
email your patches out `git send-email`, then you'll be most of the
way there.

> The AXP20X chips have a configuration register "REG 30H: VBUS-IPSOUT Power 
> Path Management" that provide USB power supply protection.
> The current axp20x_usb_power.c provides support only for reading those 
> values.
> 
> From the datasheet:
> In order not to affect the USB communication, VBUS is always working under 
> Voltage-Limit mode by default. In this mode, AXP209 ensures that VBUS 
> voltage remains above a configurable reference voltage VHOLD which can meet 
> the USB specification. The default VHOLD is 4.4V, adjustable in Reg30H 
> [5:3] register. If the system has limit on current obtained from USB VBUS, 
> a current-limit mode is provided (See REG30H[1] register), with 
> 900mA/500mA/100mA (Reg30H [0]) selectable.
> 
> The following entries are added in the axp209.dtsi 
> file: vhold-enable, vhold-set and ibus-limit
> The chosen default values are the AXP20X reset values, as described in the 
> data sheet.
> 
> Signed-off-by: Ene Alexandru <ene.alexandru@gmail.com>
> 
> 
> ---
> diff -uprN -X linux-sunxi-original/Documentation/dontdiff 
> linux-sunxi-original/arch/arm/boot/dts/axp209.dtsi 
> linux-sunxi/arch/arm/boot/dts/axp209.dtsi
> --- linux-sunxi-original/arch/arm/boot/dts/axp209.dtsi         2016-05-11 
> 09:21:47.470923679 +0200
> +++ linux-sunxi/arch/arm/boot/dts/axp209.dtsi     2016-05-10 
> 18:45:32.795158651 +0200
> @@ -98,5 +98,8 @@
>            usb_power_supply: usb_power_supply {
>                        compatible = "x-powers,axp202-usb-power-supply";
>                        status = "disabled";
> +                      vhold-enable = <0x01>;
> +                      vhold-set = <0x04>;
> +                      ibus-limit = <0x01>;
>            };
> };
> ---
> 


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
