From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Thu, 26 Jun 2014 11:48:17 +0900
Subject: [PATCH v5 2/2] ARM: shmobile: lager: enable internal PCI
In-Reply-To: <201406242202.22807.sergei.shtylyov@cogentembedded.com>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
 <201406242202.22807.sergei.shtylyov@cogentembedded.com>
Message-ID: <53AB89F1.8040509@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

(2014/06/25 3:02), Sergei Shtylyov wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
> them.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> [Sergei: enabled PCI0]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I also tested this patch, and it works.

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro shimoda

> ---
> Changes in version 4:
> - refreshed the patch.
> 
> Changes in version 3:
> - refreshed the patch.
> 
> Changes in version 2:
> - enabled PCI0 device;
> - reworded summary and changelog;
> - refreshed the patch.
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
> +++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -219,6 +219,21 @@
>  		renesas,groups = "i2c3";
>  		renesas,function = "i2c3";
>  	};
> +
> +	usb0_pins: usb0 {
> +		renesas,groups = "usb0";
> +		renesas,function = "usb0";
> +	};
> +
> +	usb1_pins: usb1 {
> +		renesas,groups = "usb1";
> +		renesas,function = "usb1";
> +	};
> +
> +	usb2_pins: usb2 {
> +		renesas,groups = "usb2";
> +		renesas,function = "usb2";
> +	};
>  };
>  
>  &ether {
> @@ -368,3 +383,21 @@
>  		regulator-always-on;
>  	};
>  };
> +
> +&pci0 {
> +	status = "okay";
> +	pinctrl-0 = <&usb0_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&pci1 {
> +	status = "okay";
> +	pinctrl-0 = <&usb1_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&pci2 {
> +	status = "okay";
> +	pinctrl-0 = <&usb2_pins>;
> +	pinctrl-names = "default";
> +};
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
