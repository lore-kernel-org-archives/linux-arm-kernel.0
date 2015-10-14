From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 14 Oct 2015 10:18:10 +0200
Subject: [PATCH v5 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <561D0C10.4060002@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <5614BADD.1070307@rock-chips.com> <5614DBE2.6080102@osg.samsung.com>
 <5614DFBC.8060105@rock-chips.com> <5614E553.6060108@osg.samsung.com>
 <5614FC6B.4080702@rock-chips.com> <56150128.2070309@osg.samsung.com>
 <5615BB93.9020008@rock-chips.com> <56192135.2080608@rock-chips.com>
 <561CCD09.6020801@osg.samsung.com> <561D0C10.4060002@rock-chips.com>
Message-ID: <561E0FC2.1070603@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yakir,

On 10/13/2015 03:50 PM, Yakir Yang wrote:
> On 10/13/2015 05:21 PM, Javier Martinez Canillas wrote:
> 

[snip]

>>> And it's better to enable pstore function on mainline kernel, so we can analysis the last log when
>>> the mainline kernel crashed. After enable PSTORE_RAM in .config, we still need add ramoops node
>> Interesting, I knew about pstore but I never used it with the Exynos Chromebooks.
>>
>>> into file, like:
>>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>>> @@ -750,6 +750,15 @@
>>>                  iommu = <&sysmmu_gsc3>;
>>>          };
>>>
>>> +       ramoops: ramoops {
>>> +               compatible = "ramoops";
>>> +               name = "ramoops";
>>> +               reg = <0x41f00000 0x100000>;
>>> +               record-size = <0x20000>;
>>> +               dump-oops;
>>> +               status = "okay";
>>> +       };
>>> +
>> Are you using mainline? There isn't a "ramoops" compatible string documented
>> in the upstream DT bindings, platform_match() would match by driver name as
>> a fallback but I don't see code in fs/pstore/ram.c that parses the properties
>> in your device node. I wonder how this works for you or did I missunderstand?
> 
> Aha, I lost some things that I back port the pstore/ram.c from chrome
> v3.14 tree which driver would parsed the "ramoops" compatible.
>

Ah, that explains it then.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
