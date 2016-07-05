From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 5 Jul 2016 16:43:02 +0300
Subject: [PATCH v2 3/3] ARM: dts: blanche: add Ethernet pins
In-Reply-To: <CAMuHMdU3yDe7fFtVArMGqMc6oyHXtFxeR8t6cqPranSg7R+12g@mail.gmail.com>
References: <2793535.9X0Tq7I1Mq@wasted.cogentembedded.com>
 <3279336.lifIduxqUW@wasted.cogentembedded.com>
 <CAMuHMdU3yDe7fFtVArMGqMc6oyHXtFxeR8t6cqPranSg7R+12g@mail.gmail.com>
Message-ID: <9dc3a8b0-540b-9777-fce4-813eb6c2578e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2016 10:29 AM, Geert Uytterhoeven wrote:

>> Add the (previously omitted) pin data for the SMSC LAN89218 Ethernet chip
>> to the Blanche board's device tree: the chip's IRQ output is connected to
>> the SoC's IRQ0 pin and its nCS input is connected to the SoC's EX_CS0# pin.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  arch/arm/boot/dts/r8a7792-blanche.dts |   15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
[...]
>> @@ -67,6 +70,18 @@
>>                 groups = "scif3_data";
>>                 function = "scif3";
>>         };
>> +
>> +       lan89218_pins: lan89218 {
>> +               intc {
>> +                       groups = "intc_irq0";
>> +                       function = "intc";
>> +               };
>> +               lbsc {
>> +                       groups = "lbsc_ex_cs0";
>> +                       function = "lbsc";
>
> Don't you need pinctrl for the other LBSC pins, like the address and data lines
> (Ax and Dy)?
>

    Unlike the chip selects, the address/data lines are not "monopolized" by a 
single device, so I'm not sure what to do with them...

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
