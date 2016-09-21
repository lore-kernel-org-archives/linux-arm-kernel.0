From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 21 Sep 2016 10:15:15 +0100
Subject: [PATCH 3/4] ARM: tegra: nyan-big: Include compatible revisions
 for proper detection
In-Reply-To: <1474443809.1239.4.camel@paulk.fr>
References: <20160828173246.32621-1-contact@paulk.fr>
 <20160828173246.32621-3-contact@paulk.fr>
 <a9485a88-55a5-9dd1-1a1b-a6c0a78ff476@nvidia.com>
 <1474394004.1215.2.camel@paulk.fr>
 <d05b8e5a-adf7-9057-b42a-0da1fde84953@nvidia.com>
 <1474394544.1215.13.camel@paulk.fr>
 <6501341f-e14c-4876-dcb7-60a33b7621c4@nvidia.com>
 <1474443809.1239.4.camel@paulk.fr>
Message-ID: <5461eb20-9372-7fa1-0e48-3d0143393b8c@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/09/16 08:43, Paul Kocialkowski wrote:

...

>>>>>>> Depthcharge (the payload used with cros devices) will attempt to
>>>>>>> detect
>>>>>>> boards using their revision. This includes all the known revisions
>>>>>>> for
>>>>>>> the nyan-big board so that the dtb can be selected preferably.
>>>>>>
>>>>>> May be I am missing something here, but for the mainline there is only
>>>>>> one dtb available and so why is this needed for the mainline?
>>>>>
>>>>> There is indeed a single dts in mainline, but depthcharge will use the
>>>>> revision
>>>>> to match the compatible string (e.g. it will look for google,nyan-big-
>>>>> rev5,
>>>>> not
>>>>> google,nyan-big), so we need to list them all in that single dts.
>>>>> Otherwise,
>>>>> depthcharge will fall back to the default config, which may or may not
>>>>> be
>>>>> suitable for nyan.
>>>>
>>>> Is tegra124-nyan-big.dtb not the default?
>>>
>>> You can't expect that to always be the case. The image format allows many
>>> different dts to be provided, so I could easily build with
>>> multi_v7_defconfig
>>> and have various dts for various devices in the same image, and just select
>>> a
>>> random one as default.
>>
>> Really? Sounds odd. I was hoping that tegra124-nyan-big.dtb would be a
>> catch all.

I meant I was hoping that compatible = "google,nyan-big" would be the
catchall not the dtb file name ;-)

> Yes, the image format (FIT) allows specifying multiple dtb and zImage
> combinations in the same image[0].

Yes I am aware of that. Typically, I have been testing using a FIT image
with single zImage and dtb. Hence no problems.

So are you wanting to create a FIT image to support multiple boards and
use the single FIT image for all? If so then I can see why you want
this. Again please describe the motivation for the changes in the
changelog so it is clear why we are adding this.

Cheers
Jon

-- 
nvpublic
