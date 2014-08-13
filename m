From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 13 Aug 2014 11:42:53 +0300
Subject: [PATCH 0/3] Thermal reset support in PMC
In-Reply-To: <53EB1DF5.301@nvidia.com>
References: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
 <20140813080744.GD7735@ulmo> <53EB1DF5.301@nvidia.com>
Message-ID: <53EB250D.5070207@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/08/14 11:12, Mikko Perttunen wrote:
> On 13/08/14 11:07, Thierry Reding wrote:
>> * PGP Signed by an unknown key
>>
>> On Tue, Aug 05, 2014 at 11:12:57AM +0300, Mikko Perttunen wrote:
>>> Hi,
>>>
>>> this series adds support for hardware-triggered thermal reset to the PMC
>>> driver. Namely, it adds device tree properties for specifying the I2C
>>> command to be sent when thermtrip is triggered. It is to be noted
>>> that thermtrip won't be ever triggered without a soctherm driver to
>>> calibrate the sensors, but I'll follow up with that patch.
>>>
>>> pmc.c required some juggling around to make the match data usable in
>>> probe, since I didn't want to put the code into the initcall either, since
>>> the soctherm driver won't be initialized by that point anyway.
>>>
>>> Series tested on Jetson-TK1. Should work on Tegra30 and Tegra114 too.
>>
>> Can you describe the procedure used to test this? We currently have a
>> bunch of features in Tegra that some people have tested at some point
>> during development but the test procedures never got documented. That
>> means whenever we want to test something we need to go and reinvent a
>> bunch of tests after the fact.
>>
>> So what I'd like to start doing is collect tests (preferably in some
>> scripted way) so that they can be kept in a repository that people can
>> easily clone and run on devices.
>>
>> Could you provide something like that for thermtrip?
>
> Sure. I'll see if I can make a just a test script or if a local patch is
> needed to test. Btw, I also have a pretty nice test script for EMC
> ready, and I agree that such a repository would be very nice.

Here is a test program. It it works, the device with immediately shut down.

https://gist.github.com/cyndis/66126c9c176b5f94a76f

>
>>
>> Thierry
>>
>> * Unknown Key
>> * 0x7F3EB3A1
>>
>
> Cheers, Mikko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
