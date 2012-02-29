From: tim.bird@am.sony.com (Tim Bird)
Date: Wed, 29 Feb 2012 10:33:58 -0800
Subject: [PATCH 1/2] ARM: Add Kconfig option to use mkimage -T
 kernel_noload
In-Reply-To: <20120229181430.GI3318@game.jcrosoft.org>
References: <1330473804-23348-1-git-send-email-swarren@nvidia.com>
 <20120229122942.GF3318@game.jcrosoft.org>
 <74CDBE0F657A3D45AFBB94109FB122FF17BDDF206A@HQMAIL01.nvidia.com>
 <20120229181430.GI3318@game.jcrosoft.org>
Message-ID: <4F4E6F96.8080907@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2012 10:14 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 08:58 Wed 29 Feb     , Stephen Warren wrote:
>> Jean-Christophe PLAGNIOL-VILLARD wrote at Wednesday, February 29, 2012 5:30 AM:
>>> On 17:03 Tue 28 Feb     , Stephen Warren wrote:
>>>> uImage files typically encode a single absolute load and entry address.
>>>> This is inconvenient when attempting to share that uImage across multiple
>>>> SoCs with different physical RAM addresses. Recent versions of mkimage
>>>> implement a "kernel_noload" image type which encodes no absolute load
>>>> address, and a relative entry address. This works well for uImage-wrapped
>>>> ARM zImages, since they are relocatable.
>>>>
>>>> This is enabled by commit b9b50e89d317c58becd0e2d7fac2e21e3a81dd0a
>>>> "image: Implement IH_TYPE_KERNEL_NOLOAD" in U-Boot.
>>>>
>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>> ---
>>>> I assume I should put this into the ARM patch tracker if it's OK?
>>>
>>> Again a new option for uImage no why not just boot the zImage
>>>
>>> in this case the uImage is useless
>>
>> U-Boot doesn't support zImage at present.
>>
>> A patch was posted to support it at least for ARM, but needed a little
>> work before it could be committed.
> Sorry I see no advantage to have the uImage build by the kernel anymore as
> we have a relocatable zImage
> 
> I'll even drop its support

This seems at least premature, and possibly ill-advised in general.
There are lots of U-Boot images out in the field, many of which that
are rarely updated. A lot of workflow will be disrupted unnecessarily
by a change like this.

Could you wait to drop uImage build support in the kernel until
U-Boot supports zImage, and has worked it's way into the field
for a few years?
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
