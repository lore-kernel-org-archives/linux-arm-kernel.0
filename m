From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 26 Feb 2018 12:15:39 +0100
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <20180226105510.azlj56eohhu5wu3n@verge.net.au>
References: <20180217020756.21474-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdUiGAV7r55mqRH549BufDsh8_j8_S-BD_49sCM=aO9hZQ@mail.gmail.com>
 <2860322f-89b9-32aa-37bc-4fa4a52c1837@gmail.com>
 <20180226105510.azlj56eohhu5wu3n@verge.net.au>
Message-ID: <0a1597df-a9ba-c178-3af2-042cb3e31de4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2018 11:55 AM, Simon Horman wrote:
> On Sat, Feb 24, 2018 at 11:11:31PM +0100, Marek Vasut wrote:
>> On 02/18/2018 04:07 PM, Geert Uytterhoeven wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> CC Steve Twiss
>>>
>>> On Sat, Feb 17, 2018 at 3:07 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
>>>> one DA9063 and one DA9210 on Porter, the only difference from
>>>> the other boards is that DA9063 is at I2C address 0x5a rather
>>>> than 0x58 .
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>
>>> Thanks for your patch!
>>>
>>>> --- a/arch/arm/boot/dts/r8a7791-porter.dts
>>>> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
>>>> @@ -354,10 +354,47 @@
>>>>         clock-frequency = <400000>;
>>>>  };
>>>>
>>>> +&i2c6 {
>>>> +       status = "okay";
>>>> +       clock-frequency = <100000>;
>>>> +
>>>> +       pmic at 5a {
>>>> +               compatible = "dlg,da9063";
>>>
>>> Does it matter that this is a DA9063L ("Variant 6B")?
>>> Do we need a new compatible value, or can this be detected at runtime?
>>
>> The driver detects it
>>
>> da9063 6-005a: Device detected (chip-ID: 0x61, var-ID: 0x63)
>>
>> Comparing the datasheets makes it obvious that 9063L is just a cut-down
>> version of 9063, with less LDOs and one less ADC. So I think we should
>> have extra compatible and have the driver restrict which LDOs can be
>> used with this smaller PMIC.
> 
> Thanks, and sorry to ping yo about this while you were in transit.
> 
> It sounds like this patch should be updated.
> Accordingly I'm marking it as "Changes Requested".

Correct

-- 
Best regards,
Marek Vasut
