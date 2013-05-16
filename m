From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 16 May 2013 20:00:17 +0800
Subject: [alsa-devel] [PATCH] ASoC: dfbmcs320: make the driver common for
 other BT modules
In-Reply-To: <5194C2FC.70804@metafoo.de>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
 <5194AC3C.4080206@metafoo.de>
 <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
 <5194C2FC.70804@metafoo.de>
Message-ID: <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/5/16 Lars-Peter Clausen <lars@metafoo.de>:
> On 05/16/2013 12:31 PM, Barry Song wrote:
>> 2013/5/16 Lars-Peter Clausen <lars@metafoo.de>:
>>> On 05/16/2013 08:53 AM, Barry Song wrote:
>>>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>>>> we don't want everyone to have a seperate codec driver. anyway, the
>>>> feature of Bluetooth handsfree is same on all platforms, so this patch
>>>> makes the DFBM-CS320 driver become a common BT handsfree driver.
>>> [...]
>>>> -static struct platform_driver dfmcs320_driver = {
>>>> +static struct platform_driver bt_handsfree_driver = {
>>>>       .driver = {
>>>> -             .name = "dfbmcs320",
>>>> +             .name = "bt-handsfree",
>>>>               .owner = THIS_MODULE,
>>>
>>> In my opinion it's a good idea to keep a platform_id list of all the
>>> supported devices.
>>
>> i have no idea how many bluetooth handsfree module exist in the world.
>> there must be many. actually the driver works for almost all BT
>> handsfree.
>> so my basic idea is making the codes as common as possible.
>
> you don't have to know all the device names, but I'd prefer to keep at least
> dfbmcs320 in the device id list.

i did think it is a good idea to have device id list while i sent the
last mail. and it matches with the generic device driver engineering
sense. the problem is i don't how long the list will be.
if you like to keep dfbmcs320 at least for the moment, i would agree.

>
> - Lars

-barry
