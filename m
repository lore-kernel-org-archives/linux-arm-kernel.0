From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 7 Jun 2017 11:15:21 +0200
Subject: [PATCH v4 3/3] media: mtk-mdp: Fix mdp device tree
In-Reply-To: <35fb23dd-00e2-e0f1-c3ed-e317883ed007@gmail.com>
References: <1495509851-29159-1-git-send-email-minghsiu.tsai@mediatek.com>
 <1495509851-29159-4-git-send-email-minghsiu.tsai@mediatek.com>
 <e7996ad5-03a1-7b53-5d61-ae171473581f@gmail.com>
 <2407aa14-610d-0252-f264-edf22961752e@xs4all.nl>
 <59ac9ca0-3f2f-fa65-011d-c832e4ced265@gmail.com>
 <9ca0b2c5-db3d-4794-1431-89f5a093252f@xs4all.nl>
 <35fb23dd-00e2-e0f1-c3ed-e317883ed007@gmail.com>
Message-ID: <8dadf7c7-d600-ec0d-b78f-3bb492873edc@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/17 11:13, Matthias Brugger wrote:
> 
> 
> On 07/06/17 11:11, Hans Verkuil wrote:
>> On 07/06/17 11:07, Matthias Brugger wrote:
>>>
>>>
>>> On 07/06/17 10:56, Hans Verkuil wrote:
>>>> On 07/06/17 10:44, Matthias Brugger wrote:
>>>>> Hi Hans, hi Mauro,
>>>>>
>>>>> On 23/05/17 05:24, Minghsiu Tsai wrote:
>>>>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>>>>
>>>>>> If the mdp_* nodes are under an mdp sub-node, their corresponding
>>>>>> platform device does not automatically get its iommu assigned properly.
>>>>>>
>>>>>> Fix this by moving the mdp component nodes up a level such that they are
>>>>>> siblings of mdp and all other SoC subsystems.  This also simplifies the
>>>>>> device tree.
>>>>>>
>>>>>> Although it fixes iommu assignment issue, it also break compatibility
>>>>>> with old device tree. So, the patch in driver is needed to iterate over
>>>>>> sibling mdp device nodes, not child ones, to keep driver work properly.
>>>>>>
>>>>>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>>>>>> Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
>>>>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>>>>
>>>>>
>>>>> Are you OK to take this patch, or do you have any further comments?
>>>>
>>>> Nope, it's all good. Queued for 4.13.
>>>>
>>>
>>> Thanks!
>>>
>>> I queued the other two in v4.12-next/dts64
>>
>> Media bindings normally go through the media subsystem, but you've taken
>> that one as well? I need to know, because then I drop it in my tree.
>>
> 
> My fault, I'll drop it from my tree. After that I only queued patch 2/3.

OK, thanks. Then I'll take patch 1/3 and 3/3.

Regards,

	Hans
