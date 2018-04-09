From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 08:21:17 -0500
Subject: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
In-Reply-To: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
 <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
Message-ID: <CAL_Jsq+AsUiWWBQ7K4OUM58KqQbvBHuFYmXxXLwr7viwoKW-Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2018 at 12:38 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> Rob,

Please don't top post to lists.

> this binding is for a specific IP block (for measuring/aggregating input
> pulses) on the Tegra186 SoC, so I don't think it fits into any generic
> binding.

What is it hooked up to to measure? You only mention "fan" five times
in the doc.

You have #pwm-cells too, so this block has PWM output as well? If not,
then where's the PWM for the fan control because there is no point in
having fan tach without some control mechanism.

There's only so many ways to control fans and types of fans, so yes,
the interface of control and feedback lines between a fan and its
controller should absolutely be generic.

Rob

>
> Thanks,
> Mikko
>
>
> On 03/27/2018 05:52 PM, Rob Herring wrote:
>>
>> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>>>
>>> Supply Device tree binding documentation for the NVIDIA
>>> Tegra186 SoC's Tachometer Controller
>>>
>>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>>> ---
>>>
>>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>>      Renamed dt property values of clock-names and reset-names to
>>> "tachometer"
>>>      from "tach"
>>
>>
>> Read my prior comments on v1.
>>
>> Rob
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
