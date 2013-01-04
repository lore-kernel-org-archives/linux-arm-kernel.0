From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 04 Jan 2013 09:15:44 +0100
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
In-Reply-To: <1357284783.2152.2.camel@rzhang1-mobl4>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch>
 <CABMQnV+zNWz4UJ_127Xe+MkTt9eQVPA8StJzyEXt58Z4OqZBYw@mail.gmail.com>
 <20121214221159.GE7717@lunn.ch> <1357284783.2152.2.camel@rzhang1-mobl4>
Message-ID: <50E68FB0.9050807@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/13 08:33, Zhang Rui wrote:
> On Fri, 2012-12-14 at 23:11 +0100, Andrew Lunn wrote:
>> On Sat, Dec 15, 2012 at 06:54:17AM +0900, Nobuhiro Iwamatsu wrote:
>>> Hi,
>>>
>>> Thanks you for your work.
>>> Sorry, I dont hava a time at this week about this.
>>
>> Its not a problem. We have plenty of time before the next merge
>> window. I was just interested in seeing it work on my QNAP device, so
>> did some of the cleanup work.
>>
>>> On Fri, Dec 14, 2012 at 8:03 PM, Andrew Lunn<andrew@lunn.ch>  wrote:
>>>> From: Nobuhiro Iwamatsu<iwamatsu@nigauri.org>
>>>>
>>>> Some Orion SoC has thermal sensor.
>>>> This patch adds support for 88F6282 and 88F6283.
>>>>
>>>> Signed-off-by: Nobuhiro Iwamatsu<iwamatsu@nigauri.org>
>>>> Signed-off-by: Andrew Lunn<andrew@lunn.ch>
>>>> ---
>>>>   .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
>>>>   drivers/thermal/Kconfig                            |    7 ++
>>>>   drivers/thermal/Makefile                           |    1 +
>>>>   drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
>>>>   4 files changed, 157 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>>>   create mode 100644 drivers/thermal/orion_thermal.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/thermal/orion-thermal.txt b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>>> new file mode 100644
>>>> index 0000000..5ce925d
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>>> @@ -0,0 +1,16 @@
>>>> +* Orion Thermal
>>>> +
>>>> +This initial version is for Kirkwood 88F8262&  88F6283 SoCs, however
>>>> +it is expected the driver will sometime in the future be expanded to
>>>> +also support Dove, using a different compatibility string.
>>>> +
>>>> +Required properties:
>>>> +- compatible : "marvell,kirkwood-thermal"
>>>> +- reg : Address range of the thermal registers
>>>> +
>>>> +Example:
>>>> +
>>>> +       thermal at 10078 {
>>>> +               compatible = "marvell,kirkwood";
>>>
>>> compatible = "marvell,kirkwood-thermal"; ?
>>
>> Yep, my error.
>>
>>>> +               reg =<0x10078 0x4>;
>>>> +       };
>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>> index e1cb6bd..3bba13f 100644
>>>> --- a/drivers/thermal/Kconfig
>>>> +++ b/drivers/thermal/Kconfig
>>>> @@ -55,3 +55,10 @@ config EXYNOS_THERMAL
>>>>          help
>>>>            If you say yes here you get support for TMU (Thermal Managment
>>>>            Unit) on SAMSUNG EXYNOS series of SoC.
>>>> +
>>>> +config ORION_THERMAL
>>>> +       tristate "Temperature sensor on Marvel Orion SoCs"
>>>
>>> Marvel ->  Marvell
>>
>> Missed that one, thanks.
>>
>> Thanks for the Tested-by. I will add it to the next version.  I
>> started work on Dove support, so i will probably repost when i have
>> that ready for testing.
>
> sorry for the late response, can you resend the refreshed version on top
> of the thermal next tree?

Hi Rui

Im in the process of generalizing the driver so that it works for 
Kirkwood, Dove, Armada 370 and Armada XP. The combined driver is not 
finished yet. Once i have something ready i will repost.

	Andrew
