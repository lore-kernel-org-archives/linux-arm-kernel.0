From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Feb 2015 11:35:55 +0100
Subject: [PATCH 09/11] ARM: berlin: rework chip and system controller
 nodes for BG2
In-Reply-To: <20150218103322.GA16432@kwain>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423671332-24580-10-git-send-email-antoine.tenart@free-electrons.com>
 <54E4699E.4010909@gmail.com> <20150218103322.GA16432@kwain>
Message-ID: <54E46B0B.4010703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.02.2015 11:33, Antoine Tenart wrote:
> On Wed, Feb 18, 2015 at 11:29:50AM +0100, Sebastian Hesselbarth wrote:
>> On 11.02.2015 17:15, Antoine Tenart wrote:
>> [...]
>>> -		chip: chip-control at ea0000 {
>>> -			compatible = "marvell,berlin2-chip-ctrl";
>>> -			#clock-cells = <1>;
>>> -			#reset-cells = <2>;
>>> +		chip: chip-controller at ea0000 {
>>> +			compatible = "marvell,berlin2-chip-ctrl", "syscon";
>>>   			reg = <0xea0000 0x400>;
>>> +			#clock-cells = <1>;
>>
>> I noticed just now, but we should either have all of clock, reset,
>> pinctrl as sub-nodes or none. Currently, this has pinctrl and reset
>> as sub-nodes but clock hooked up to chip-controller.
>
> Of course. The clock rework is part of the other series[1] which
> modifies the clock driver to use regmap but also move the clock into
> its own sub-node.

Ah, ok. I misinterpreted the addition of #clock-cells above, but it
gets removed and re-added again.

Sebastian
