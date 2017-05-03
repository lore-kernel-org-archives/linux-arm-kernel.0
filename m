From: henri.roosen@ginzinger.com (Henri Roosen)
Date: Wed, 3 May 2017 16:27:39 +0200
Subject: [PATCH] [RFC] ARM: dts: imx6sx-sdb: Drop OPP hackery
In-Reply-To: <1493818353.11226.2.camel@nxp.com>
References: <20170425164224.26537-1-marex@denx.de>
 <a75000d6-aa53-92e3-c43a-58b49f18ff7e@denx.de>
 <1493149194.20997.3.camel@nxp.com> <1493818353.11226.2.camel@nxp.com>
Message-ID: <8467de40-ffde-9723-e09c-54785bbfeab6@ginzinger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2017 03:32 PM, Leonard Crestez wrote:
> On Tue, 2017-04-25 at 22:39 +0300, Leonard Crestez wrote:
>> On Tue, 2017-04-25 at 21:30 +0200, Marek Vasut wrote:
>>>
>>> On 04/25/2017 06:42 PM, Marek Vasut wrote:
>>>>
>>>> The imx6sx-sdb has one power supply that drives both VDDARM_IN
>>>> and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
>>>> Connect both inputs to the sw1a regulator on the PMIC and drop
>>>> the OPP hackery which is no longer needed as the power framework
>>>> will take care of the regulator configuration as needed.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> +CC Leonard
>> Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> The OPP hack only applies to LDO bypass mode and that is not in
>> upstream. When LDOs are enabled the effect is to use higher voltages
>> than necessary for no good reason.
>>
>> Setting these higher voltages can make some boards (for example Rev B)
>> fail to boot with ugly semi-random crashes reminiscent of memory
>> corruption. These failures happen the first time the lowest idle state
>> is used. This patch fixes those crashes.
>>
>> It's not clear exactly why the crashes happen. Perhaps waking up from
>> idle draws more power than is available? I don't think it matters.
>>
>> I sent a very similar patch a few minutes after this one:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503241
>> .html
>
> Adding Henri Roosen because he reported something very similar.
>
> Henri: Can you please check if this patch fixes your issue?

I've been successfully running a similar patch (reverting operating 
points, without reg_arm/reg_soc) as provided by Anson for about a month 
on an iMX6SX-SDB RevC board. I'm sorry for not copying the mailing list 
on this before.

This patch, with the regulators setup as provided by Marek, has been 
tested successfully on the iMX6SX-SDB RevC board as well.

Feel free to add my

Tested-by: Henri Roosen <henri.roosen@ginzinger.com>

-- 
Best regards,
Henri Roosen

>
> --
> Regards,
> Leonard
>
