From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 12 Apr 2012 09:26:35 +0200
Subject: [PATCH 1/4] AT91: Add DT description files for AT91SAM9N12-EK
In-Reply-To: <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
References: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
 <1334211996-31572-2-git-send-email-hong.xu@atmel.com>
Message-ID: <4F8683AB.5000004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 04/12/2012 08:26 AM, Hong Xu a ?crit :
 > Added AT91SAM9N12 SoC DT file, as well as the board definition file
 > for AT91SAM9N12-EK
 >
 > Signed-off-by: Hong Xu<hong.xu@atmel.com>
 > ---
 >   arch/arm/boot/dts/at91sam9n12.dtsi  |  223 
+++++++++++++++++++++++++++++++++++
 >   arch/arm/boot/dts/at91sam9n12ek.dts |  111 +++++++++++++++++
 >   2 files changed, 334 insertions(+), 0 deletions(-)
 >   create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
 >   create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
 >
 > diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi 
b/arch/arm/boot/dts/at91sam9n12.dtsi
 > new file mode 100644
 > index 0000000..e86372d
 > --- /dev/null
 > +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
 > @@ -0,0 +1,223 @@
 > +/*
 > + * at91sam9n12.dtsi - Device Tree include file for AT91SAM9N12 SoC
 > + *
 > + *  Copyright (C) 2012 Atmel,
 > + *                2012 Hong Xu<hong.xu@atmel.com>
 > + *
 > + * Licensed under GPLv2 or later.
 > + */
 > +
 > +/include/ "skeleton.dtsi"
 > +
 > +/ {
 > +	model = "Atmel AT91SAM9N12 SoC";
 > +	compatible = "atmel,at91sam9n12";
 > +	interrupt-parent =<&aic>;
 > +
 > +	aliases {
 > +		serial0 =&dbgu;
 > +		serial1 =&usart0;
 > +		serial2 =&usart1;
 > +		serial3 =&usart2;
 > +		serial4 =&usart3;
 > +		gpio0 =&pioA;
 > +		gpio1 =&pioB;
 > +		gpio2 =&pioC;
 > +		gpio3 =&pioD;
 > +		tcb0 =&tcb0;
 > +		tcb1 =&tcb1;
 > +	};
 > +	cpus {
 > +		cpu at 0 {
 > +			compatible = "arm,arm926ejs";
 > +		};
 > +	};
 > +
 > +	memory at 20000000 {
 > +		reg =<0x20000000 0x10000000>;
 > +	};

Please remove unit address part. Explanations here: 
http://lists-archives.com/linux-kernel/27617260-arm-at91-dt-remove-unit-address-part-for-memory-nodes.html

[...]

 > diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts 
b/arch/arm/boot/dts/at91sam9n12ek.dts
 > new file mode 100644
 > index 0000000..56b012f
 > --- /dev/null
 > +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
 > @@ -0,0 +1,111 @@
 > +/*
 > + * at91sam9n12ek.dts - Device Tree file for AT91SAM9N12-EK board
 > + *
 > + *  Copyright (C) 2012 Atmel,
 > + *                2012 Hong Xu<hong.xu@atmel.com>
 > + *
 > + * Licensed under GPLv2 or later.
 > + */
 > +/dts-v1/;
 > +/include/ "at91sam9n12.dtsi"
 > +
 > +/ {
 > +	model = "Atmel AT91SAM9N12-EK";
 > +	compatible = "atmel,at91sam9n12ek", "atmel,at91sam9n12", 
"atmel,at91sam9";
 > +
 > +	chosen {
 > +		bootargs = "mem=128M console=ttyS0,115200 root=/dev/mtdblock1 rw 
rootfstype=jffs2";
 > +	};
 > +
 > +	memory at 20000000 {
 > +		reg =<0x20000000 0x10000000>;
 > +	};

ditto

[...]

Regards

Ludovic
