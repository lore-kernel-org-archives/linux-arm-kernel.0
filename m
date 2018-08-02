From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 2 Aug 2018 15:55:55 +0200
Subject: [PATCH] ARM: shmobile: silk: Add DA9063 PMIC node
In-Reply-To: <CAMuHMdXib8fz3c41RX-70eA5w4ThM6e02ybmX=N=xXR6=F80KA@mail.gmail.com>
References: <20180730111817.5636-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXib8fz3c41RX-70eA5w4ThM6e02ybmX=N=xXR6=F80KA@mail.gmail.com>
Message-ID: <42d09bc8-a883-c3af-b0d6-0087b6e2558e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2018 02:32 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Mon, Jul 30, 2018 at 1:18 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> Add DA9063 PMIC node to the I2C bus.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> Oneline-summary prefix should be "ARM: dts: silk:".

Right, fixed

>> --- a/arch/arm/boot/dts/r8a7794-silk.dts
>> +++ b/arch/arm/boot/dts/r8a7794-silk.dts
>> @@ -403,6 +403,18 @@
>>         pinctrl-names = "i2c-hdmi";
>>
>>         clock-frequency = <400000>;
>> +
>> +       pmic at 5a {
> 
> Hmm, the da9063 is actually connected to two i2c buses: i2c1 (3.3v)
> and i2c7 (1.8v).
> On Koelsch, we describe the 1.8v connection, as that i2c bus
> ("i2c_dvfs") is meant
> for power control.

On Koelsch, the pmic is sitting on i2c6 only. What am I missing ?

>> +               compatible = "dlg,da9063";
>> +               reg = <0x5a>;
>> +               interrupt-parent = <&irqc0>;
>> +               interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> 
> According to my schematics, the interrupt is connected to GP3_31?

Yeah, fixed, thanks.

>> +               interrupt-controller;
>> +
>> +               wdt {
>> +                       compatible = "dlg,da9063-watchdog";
>> +               };
>> +       };
>>  };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
Best regards,
Marek Vasut
