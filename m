From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 May 2015 16:44:06 +0100
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmh=tQRJymDCAevNC_gv+aCQnJH0tPjXX2L0BBhKbhZOYg@mail.gmail.com>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <5549B9CC.1040709@huawei.com> <20150506093022.GB31001@leverpostej>
 <5549EE97.3020801@huawei.com> <20150506104856.GC707@leverpostej>
 <CAAS=xmh=tQRJymDCAevNC_gv+aCQnJH0tPjXX2L0BBhKbhZOYg@mail.gmail.com>
Message-ID: <20150506154406.GB2974@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> How about add the following binding rule to my 2/5 patch:
> ---------------------------
> *Hisilicon Enhanced ARM AMBA Primecell PL011 serial UART
> 
> Required properties:
> - compatible: must be "hisilicon,hi6220-uart", "arm,primecell", "arm,pl011"

"arm,primecell" should come last.

> - reg: exactly one register range with length 0x1000
> - interrupts: exactly one interrupt specifier
> 
> See also bindings/serial/pl011.txt
> 
> Example:
> 
> uart0: uart at f8015000 {
>         compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
>         reg = <0x0 0xf8015000 0x0 0x1000>;
>         interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>         clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl HI6220_UART0_PCLK>;
>         clock-names = "uartclk", "apb_pclk";
> };

How about for the moment we just modify the existing pl011 binding
document to allow for the hi6220-specific string in addition to its
existing strings? We can always split it out later if the hi6220 UART
binding needs to be significantly divergent.

> > Is UART 0 different from UART1 and UART2?
> Yes,  but my patch just includes UART0, we do some changements for UART1/2
> to improve performance.

Sure, but we need to make sure we can choose a sane compatible string
for them, that won't clash with whatever we choose for UART0.

Are they the same IP as UART0, or fundamentally different?

Are they also PL011 derived?

Thanks,
Mark.
