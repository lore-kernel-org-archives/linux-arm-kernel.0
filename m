From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 21 Sep 2017 19:03:26 +0300
Subject: [PATCH v2 8/8] arm64: dts: renesas: eagle: add EtherAVB support
In-Reply-To: <CAMuHMdXQXFuVzwW7G-U7XWZUEj8qFRjtfDQF1+TgyzO0Xb+eYg@mail.gmail.com>
References: <20170915194449.538504992@cogentembedded.com>
 <CAMuHMdXQXFuVzwW7G-U7XWZUEj8qFRjtfDQF1+TgyzO0Xb+eYg@mail.gmail.com>
Message-ID: <c0390fc1-7da4-ac60-afee-97126d1fd372@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2017 4:08 PM, Geert Uytterhoeven wrote:

>> Define the Eagle board  dependent part of the EtherAVB device node.
>> Enable DHCP  and NFS root for the kernel booting.
>>
>> Based  on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
[...]
>> @@ -43,3 +44,14 @@
>>   &scif0 {
>>          status = "okay";
>>   };
>> +
>> +&avb {
>> +       renesas,no-ether-link;
>> +       phy-handle = <&phy0>;
>> +       status = "okay";
>> +
>> +       phy0: ethernet-phy at 0 {
>> +               rxc-skew-ps = <1500>;
>> +               reg = <0>;
> 
> Any specific reason why you don't want to wire up the interrupt?
> 
>                  interrupt-parent = <&gpio2>;

    I thought it's quite obvious -- we don't have GPIOs yet, and GPIOs seem to 
require PFC.

>                  interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> 
>> +       };
>> +};
> 
> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
