From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Mar 2017 13:00:08 -0600
Subject: [PATCH V2 4/5] dt-bindings: tegra: Update compatible strings for
 Tegra flowctrl
In-Reply-To: <58983614-8f75-b498-e544-5121a16d5d19@nvidia.com>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
 <1490202056-13040-5-git-send-email-jonathanh@nvidia.com>
 <b85e7f4e-ba63-8374-b10d-3f9f04252a69@wwwdotorg.org>
 <58983614-8f75-b498-e544-5121a16d5d19@nvidia.com>
Message-ID: <f02f7dac-9b43-64ad-bf04-0cb1cbeac782@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 12:13 PM, Jon Hunter wrote:
>
> On 22/03/17 17:26, Stephen Warren wrote:
>> On 03/22/2017 11:00 AM, Jon Hunter wrote:
>>> Update the compatible strings for Tegra Flow Control driver to match
>>> the device-tree source files for Tegra.
>>
>>> +++
>>> b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
>>
>>> +  - "nvidia,tegra124-flowctrl": for Tegra124 and Tegra132
>>
>> I think that should be:
>>
>> +  - "nvidia,tegra124-flowctrl": for Tegra124
>> +  - "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl": for \
>> Tegra132
>
> This is based upon the current tegra132.dtsi file which just has ...
>
> 	flow-controller at 60007000 {
> 		compatible = "nvidia,tegra124-flowctrl";
> 		...
>
> So I can fix-it up if that is what we want/should have. I have a feeling
> there are a few other cases like this.

Yes, I'm sure we have some escapes right now. In practice we currently 
treat T124 and T132 as almost/entirely identical so it won't make any 
difference. In theory it might in the future if we find a T132-specific 
bug (unlikely, but). If you're editing up the compatible value docs, we 
may as well fix this issue while we're at it:-) Scope creep:-) This 
could happen in a separate change if you want, e.g. to make the same 
edit to all T132 or all Tegra DTs.
