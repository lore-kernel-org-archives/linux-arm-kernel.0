From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:36:19 -0700
Subject: [PATCH 01/31] ARM: tegra: add missing clock documentation to
 DT bindings
In-Reply-To: <9892703.gTmEHyqaYb@ax5200p>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-2-git-send-email-swarren@wwwdotorg.org>
 <9892703.gTmEHyqaYb@ax5200p>
Message-ID: <528A5013.3060006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2013 03:00 PM, Marc Dietrich wrote:
> Hi Stephen,
> 
> On Friday 15 November 2013 13:53:56 Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Many of the Tegra DT binding documents say nothing about the clocks or
>> clock-names properties, yet those are present and required in DT files.
>> This patch simply updates the documentation file to match the implicit
>> definition of the binding, based on real-world DT content.
>>
>> All Tegra bindings that mention clocks are updated to have consistent
>> wording and formatting of the clock-related properties.

>> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt

(Thanks for pointing out the duplicate entries; I'll fix those.)

>> +  - clocks : Must contain an entry for each entry in clock-names.
>> +    See ../clocks/clock-bindings.txt for details.
>> +  - clock-names : Must include the following entries:
>> +    (This property may be omitted if the only clock in the list is "3d")
>> +    - 3d
>> +      This MUST be the first entry.
> 
> why? isn't the purpose of names that the order is irrelevant?

If we used names from the start, then the order would be irrelevant.

However, this binding didn't use names from the start, and hence the
order of appearance in "clocks" is part of the original binding.
"clock-names" only became part of the binding when the second clock was
introduced.

We can either: (a) document the existing requirements as I have done, or
(b) go through all the bindings and drivers and make potentially
incompatible changes so that all ordering is purely defined by
"clock-names". I was tempted to do (b) for cleanliness, but didn't want
to push my luck on too many ABI-incompatible changes. (b) /might/ also
affect more drivers than this series already does, thus bloating it even
more:-(

P.S. only quoting the parts of the patch you're replying to makes it a
lot easier and quicker to find your replies.
