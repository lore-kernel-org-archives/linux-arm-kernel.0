From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 7 Jan 2013 12:06:08 +0200
Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
In-Reply-To: <50E6F6AA.4000905@lunn.ch>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch> <50E6A378.90503@ti.com>
 <50E6F6AA.4000905@lunn.ch>
Message-ID: <50EA9E10.7080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-01-2013 17:35, Andrew Lunn wrote:
> On 04/01/13 10:40, Eduardo Valentin wrote:
>> Hey Andrew,
>>
>> On 14-12-2012 13:03, Andrew Lunn wrote:
>>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>>
>>> Some Orion SoC has thermal sensor.
>>> This patch adds support for 88F6282 and 88F6283.
>>>
>>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>> .../devicetree/bindings/thermal/orion-thermal.txt | 16 +++
>>> drivers/thermal/Kconfig | 7 ++
>>> drivers/thermal/Makefile | 1 +
>>> drivers/thermal/orion_thermal.c | 133 ++++++++++++++++++++
>>> 4 files changed, 157 insertions(+)
>>> create mode 100644
>>> Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>> create mode 100644 drivers/thermal/orion_thermal.c
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>> b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>> new file mode 100644
>>> index 0000000..5ce925d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>>> @@ -0,0 +1,16 @@
>>> +* Orion Thermal
>>> +
>>> +This initial version is for Kirkwood 88F8262 & 88F6283 SoCs, however
>>> +it is expected the driver will sometime in the future be expanded to
>>> +also support Dove, using a different compatibility string.
>>> +
>>> +Required properties:
>>> +- compatible : "marvell,kirkwood-thermal"
>>> +- reg : Address range of the thermal registers
>>> +
>>> +Example:
>>> +
>>> + thermal at 10078 {
>>> + compatible = "marvell,kirkwood";
>>> + reg = <0x10078 0x4>;
>>> + };
>>
>> How do you differentiate if the SoC has the temperature sensor? On your
>> patch description you are very clear saying that this supports only
>> 88F8262 & 88F6283 SoCs.
>
> Hi Eduardo
>
> Thanks for the comments. I will address them in the next version.
>

OK. Please put me on Cc so I will keep the review.

> We differentiate between the different SoCs by DT. Each has its own
> .dtsi file and we will put the node into only those which have the
> hardware.

Ok. That I understand, but my question was more into the difference 
between 88F6282 and 88F6283. Do you need to differentiate those two? Is 
there feature set which  is specific to one which is not present in the 
second ? Because the DT entries you have you won't differentiate them, 
besides you don't read any revision register to check the chip version. 
That's my point.

>
> Thanks
>      Andrew
