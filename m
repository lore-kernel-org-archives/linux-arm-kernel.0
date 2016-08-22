From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 13:55:22 +0200
Subject: [PATCH v2 1/4] net: dt-bindings: Document the new Meson8b and
 GXBB DWMAC bindings
In-Reply-To: <20160820093538.9707-2-martin.blumenstingl@googlemail.com>
References: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
 <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160820093538.9707-2-martin.blumenstingl@googlemail.com>
Message-ID: <7308700.atIMKyMFZU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, August 20, 2016 11:35:35 AM CEST Martin Blumenstingl wrote:
> +- reg: The first register range should be the one of the DWMAC
> +       controller. The second range is is for the Amlogic specific
> +       configuration (for example the PRG_ETHERNET register range
> +       on Meson8b and newer)
>  
...

> +Example for GXBB:
> +       ethmac: ethernet at c9410000 {
> +               compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
> +               reg = <0x0 0xc9410000 0x0 0x10000>,
> +                       <0x0 0xc8834540 0x0 0x8>;
> 

The address "0xc8834540" suggests that this is part of a larger register
range that is used for various things, i.e. a "syscon" type of device.

How about making this a syscon reference rather than a "reg" address?

	Arnd
