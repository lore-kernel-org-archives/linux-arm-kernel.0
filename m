From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 16 May 2013 13:29:00 +0200
Subject: [alsa-devel] [PATCH] ASoC: dfbmcs320: make the driver common
 for other BT modules
In-Reply-To: <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
 <5194AC3C.4080206@metafoo.de>
 <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
Message-ID: <5194C2FC.70804@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 12:31 PM, Barry Song wrote:
> 2013/5/16 Lars-Peter Clausen <lars@metafoo.de>:
>> On 05/16/2013 08:53 AM, Barry Song wrote:
>>> DFBM-CS320 is only one of bluetooth modules using CSR bluetooth chips,
>>> we don't want everyone to have a seperate codec driver. anyway, the
>>> feature of Bluetooth handsfree is same on all platforms, so this patch
>>> makes the DFBM-CS320 driver become a common BT handsfree driver.
>> [...]
>>> -static struct platform_driver dfmcs320_driver = {
>>> +static struct platform_driver bt_handsfree_driver = {
>>>       .driver = {
>>> -             .name = "dfbmcs320",
>>> +             .name = "bt-handsfree",
>>>               .owner = THIS_MODULE,
>>
>> In my opinion it's a good idea to keep a platform_id list of all the
>> supported devices.
> 
> i have no idea how many bluetooth handsfree module exist in the world.
> there must be many. actually the driver works for almost all BT
> handsfree.
> so my basic idea is making the codes as common as possible.

you don't have to know all the device names, but I'd prefer to keep at least
dfbmcs320 in the device id list.

- Lars
