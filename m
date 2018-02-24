From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 24 Feb 2018 11:05:49 +0100
Subject: [PATCH] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <20180223164517.aboazzeuujgtkh7q@verge.net.au>
References: <20180217020756.21474-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdUiGAV7r55mqRH549BufDsh8_j8_S-BD_49sCM=aO9hZQ@mail.gmail.com>
 <20180223164517.aboazzeuujgtkh7q@verge.net.au>
Message-ID: <1d93db7c-e65a-e2b3-5a65-a1eb4fa1d60e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 05:45 PM, Simon Horman wrote:
> On Sun, Feb 18, 2018 at 04:07:51PM +0100, Geert Uytterhoeven wrote:
>> Hi Marek,
>>
>> CC Steve Twiss
>>
>> On Sat, Feb 17, 2018 at 3:07 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
>>> one DA9063 and one DA9210 on Porter, the only difference from
>>> the other boards is that DA9063 is at I2C address 0x5a rather
>>> than 0x58 .
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Thanks for your patch!
>>
>>> --- a/arch/arm/boot/dts/r8a7791-porter.dts
>>> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
>>> @@ -354,10 +354,47 @@
>>>         clock-frequency = <400000>;
>>>  };
>>>
>>> +&i2c6 {
>>> +       status = "okay";
>>> +       clock-frequency = <100000>;
>>> +
>>> +       pmic at 5a {
>>> +               compatible = "dlg,da9063";
>>
>> Does it matter that this is a DA9063L ("Variant 6B")?
>> Do we need a new compatible value, or can this be detected at runtime?
> 
> Hi Marek,
> 
> could you follow up on this?

Yes, ASAP, once I'm back in the office, currently I'm stuck at the airport.

-- 
Best regards,
Marek Vasut
