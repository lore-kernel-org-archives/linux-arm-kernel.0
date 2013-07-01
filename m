From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 01 Jul 2013 11:51:01 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzLzRdIFBDSTogQWRkIGRyaXZlciBmb3IgaS5NWDYgUENJ?=
 =?UTF-8?B?IEV4cHJlc3M=?=
In-Reply-To: <1372662947-27160-4-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
Message-ID: <1372665061.36667486@f35.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This adds a PCI Express port driver for the on-chip PCI Express port
> present on the i.MX6 SoC.  It is based on the PCI Express driver available
> in the Freescale BSP.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
...
> +++ b/Documentation/devicetree/bindings/pci/imx6q-pcie.txt
> @@ -0,0 +1,20 @@
> +* Freescale i.MX6Q PCI Express bridge
> +
> +Example (i.MX6Q)
> +	pcie: pcie at 01ffc000 {
> +		compatible = "fsl,imx6q-pcie";
> +		reg = <0x01ffc000 0x4000>,
> +		      <0x01000000 0x100000>,
> +		      <0x01100000 0xe00000>,
> +		      <0x01f00000 0xfc000>;
> +		interrupts = <0 122 0x04>;
> +		clocks = <&clks 186>, <&clks 189>, <&clks 196>,
> +			 <&clks 198>, <&clks 144>;
> +		clock-names = "sata_ref", "pcie_ref_125m", "lvds1_sel",
> +			      "lvds1", "pcie_axi";
> +		power-enable = <&gpio7 12 0>;
> +		pcie-reset = <&gpio3 29 0>;

Can this be replaced with regulator/reset API?

> +		wake-up = <&gpio3 22 0>;
> +		disable-endpoint = <&gpio2 16 0>;
> +	};

---
