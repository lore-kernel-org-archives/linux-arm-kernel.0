From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 10 Aug 2015 21:18:24 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: add QSPI DT support
In-Reply-To: <CAMuHMdXQJ4Hju477Ys0ujXCNdUjWOa6AuKGzLPc3YFJc_eLz+g@mail.gmail.com>
References: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
 <1768974.jEFIAaInqd@wasted.cogentembedded.com>
 <CAMuHMdXQJ4Hju477Ys0ujXCNdUjWOa6AuKGzLPc3YFJc_eLz+g@mail.gmail.com>
Message-ID: <55C8EAF0.7060600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/10/2015 05:38 PM, Geert Uytterhoeven wrote:

>> Define the SILK board dependent part of the QSPI device node.
>> Add device nodes  for Spansion  S25FL512S SPI flash and MTD partitions on it.

>> Based on the original patch by Vladimir Barinov
>> <vladimir.barinov@cogentembedded.com>.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> --- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
>> +++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
>
>> +&qspi {
>> +       pinctrl-0 = <&qspi_pins>;
>> +       pinctrl-names = "default";
>> +
>> +       status = "okay";
>> +
>> +       flash at 0 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               compatible = "spansion,s25fl512s";

> Please add the "jedec,spi-nor" fallback.

    Hm, spi-nor.c alone can't control this device, it's rather m25p80.c that's 
the real driver. So if a fallback needs to be added indeed it should be 
"st,m25p80" I think...

[...]

> Gr{oetje,eeting}s,

MBR, Sergei
