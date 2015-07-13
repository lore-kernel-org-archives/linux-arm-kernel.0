From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 13 Jul 2015 10:20:24 +0200
Subject: [PATCH 3/3] mfd: max77686: Split out regulator part from the DT
 binding
In-Reply-To: <55A370CE.6080904@samsung.com>
References: <1436773348-15316-1-git-send-email-javier@osg.samsung.com>
 <1436773348-15316-4-git-send-email-javier@osg.samsung.com>
 <55A370CE.6080904@samsung.com>
Message-ID: <55A374C8.8020103@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/13/2015 10:03 AM, Krzysztof Kozlowski wrote:
> On 13.07.2015 16:42, Javier Martinez Canillas wrote:
>> The Maxim MAX77686 PMIC is a multi-function device with regulators,
>> clocks and a RTC. The DT bindings for the clocks are in a separate
>> file but the bindings for the regulators are inside the mfd part.
>>
>> To make it consistent with the clocks portion of the binding and
>> because is more natural to look for regulator bindings under the
>> bindings/regulator sub-directory, split the regulator portion of
>> the DT binding and add it as a separate file.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>>  Documentation/devicetree/bindings/mfd/max77686.txt | 58 +-----------------
>>  .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
>>  2 files changed, 74 insertions(+), 55 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
> 
> Actually I would prefer the opposite - merging everything into one file
> (clocks, regulators -> mfd) because:
> 
> 1. Separate files introduce some duplication (like introduction and
> common part of example node).
> 
> 2. It is easier to track the changes and update them. For example when
> adding a new chipset to the driver one may forgot about updating other
> files. When moving files one may forgot to update hard-coded path in
> some other file.
> 
> 3. When comparing existing DTS with documentation or when creating new
> DTS for the device it is just faster to fetch everything (knowledge,
> example node) from one file.
>

Yes, I also wondered about going the opposite way but then thought
that is more natural to look for clock bindings under bindings/clock
and for regulators drivers under bindings/regulator...
 
> However I understand that such opinion may be not suited for the idea of
> MFD...
>

...but I don't have a strong opinion and can do the other way if folks
are more fond with that single file approach.

What I think is that it should be consistent, either everything is in mfd
for all PMICs or everything is split.

The max77686 for example has a somehow arbitrary split since the clocks
are in another file but the regulators are in the same mfd binding doc.

> Best regards,
> Krzysztof
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
