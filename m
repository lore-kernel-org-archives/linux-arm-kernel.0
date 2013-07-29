From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 30 Jul 2013 00:45:24 +0200
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
Message-ID: <1706112.Xn49tiCSKF@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 of July 2013 18:23:30 jonsmirl at gmail.com wrote:
> The schema should enforce some kind of regularity into the description
> of similar devices.  Take SPI for example. I pulled these SPI
> controller definitions from the kernel source. Obviously all of these
> controllers are different, but it seems to me that their definitions
> could be made more regular. DMA seems like it could use a lot of help.

Well, there is not much in common in bindings for all those SPI controllers, 
other than general device attributes, such as compatible and reg (not even 
interrupts - see spi-gpio).

There is a lot of generic binding templates (as I called this kind of bindings 
in my first mail) involved here, though.

Taking one of the controllers as the example:
> spi0: spi at f0000000 {
> #address-cells = <1>;
> #size-cells = <0>;
> compatible = "atmel,at91rm9200-spi";
> reg = <0xf0000000 0x100>;
> interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;

/inherit/ "interrupts.dtss", 1;

> dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(1)>,
>       <&dma0 1 AT91_DMA_CFG_PER_ID(2)>;
> dma-names = "tx", "rx";

/inherit/ "dma.dtss", "tx", "rx";

> pinctrl-names = "default";
> pinctrl-0 = <&pinctrl_spi0>;

/inherit/ "pinctrl.dtss","default";

> status = "disabled";
> };

Best regards,
Tomasz
