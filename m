From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 17 Oct 2017 16:02:20 +0100
Subject: [PATCH v3 0/8] ARM: NOMMU: MPU updates
In-Reply-To: <20171017145614.GQ20805@n2100.armlinux.org.uk>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
 <CA+M3ks7bge8k-5p8cMVHuYX6VLbPPrs9-onj4SoL_tNvcsySGw@mail.gmail.com>
 <79c7c3f6-9a55-9044-6a6f-df8f64c10241@arm.com>
 <20171017144656.GP20805@n2100.armlinux.org.uk>
 <20171017145614.GQ20805@n2100.armlinux.org.uk>
Message-ID: <b338112c-7c5a-9455-805e-bd0e5ab9ec6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/17 15:56, Russell King - ARM Linux wrote:
> On Tue, Oct 17, 2017 at 03:46:56PM +0100, Russell King - ARM Linux wrote:
>> On Tue, Oct 17, 2017 at 03:13:36PM +0100, Vladimir Murzin wrote:
>>> On 17/10/17 15:05, Benjamin Gaignard wrote:
>>>> 2017-09-25 11:05 GMT+02:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>>>>> Hi,
>>>>>
>>>>> This is an update of the existent MPU code which consist set of
>>>>> clean-ups and enhancements. The most significant changes are in the
>>>>> way how MPU settings sync-up for secondaries (PATCH 3/8), more
>>>>> flexible layout for memory (PATCH 7/8) and support for XIP (PATCH
>>>>> 8/8). Since there is no in-tree user of MPU, support for M-class has
>>>>> been added (PATCH 6/8).
>>>>>
>>>>> There is also practical benefit of patch set:
>>>>>
>>>>> "These MPU patches introduce a nice feature that it simplifies the
>>>>> bootloader: do not need to setup the MPU, for example for coherent DMA
>>>>> region, which is described in device-tree too." Andr?s Szemz?
>>>>>
>>>>> Changelog:
>>>>>            v2 -> v3
>>>>>               - fixed support for XIP (PATCH 8/8)
>>>>>               - rebased on 4.14-rc2
>>>>>
>>>>>            v1 -> v2
>>>>>               - support for XIP (PATCH 8/8)
>>>>>               - rebased on 4.13-rc1
>>>>>
>>>>>         RFC v2 -> v1
>>>>>                - dropped RFC tag
>>>>>                - Tested-by from Andr?s
>>>>>                - rebased on 4.12-rc5
>>>>>
>>>>>            RFC -> RFC v2
>>>>>                - fixed MPU enable for v7m (PATCH 6/7)
>>>>>
>>>>> Thanks!
>>>>
>>>> for the whole serie on stm32f4 and stm32f7:
>>>>
>>>> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>
>>> Thanks for giving it a try!
>>>
>>> The series is already in Russell's patch system, so I dunno
>>> how to add your Tested-by, maybe Russell can made an update
>>> when he pull patches in his tree...
>>
>> Applied, along with the tested-by, and with the fixup patch folded.
>>
>> However, I notice that with "Szemz? Andr?s" name, the ? character has
>> been replaced by a "?" somewhere along the lines (and my VT console
>> can't even display it, so (a) I've no idea what character it's
>> supposed to be, and (b) I can't cut'n'paste it either - as illustrated
>> by my pasting above making it come out as a rectangular block.)
>>
>> The problem I have is that if I push these patches out, as soon as I
>> do, I can't fix this up, because it's the "devel-stable" branch - and
>> the promise I make to everyone is that branch is never rebased (which
>> is why it has the -stable suffix.)  Once commits are published in that
>> branch, they're set in stone.
>>
>> From what I can tell, the patches were emailed to the patch system,
>> which means it would've gone through perl's Unicode::Map8 - internally
>> the patch system uses UTF-8 to store the summary and description,
>> while preserving the patch as a byte stream.  Your emails to the list
>> claim to be UTF-8, so it should've been a no-op.  So, don't know what
>> has happened, and I can't fix it at the moment, not even in the actual
>> commits.
>>
>> So, I won't be pushing this out, nor will I be marking the patches as
>> applied in the patch system until I have some kind of solution.
> 
> Okay, seems not to be the patch system's email parsing - saving one of
> your messages from the list and feeding that into the mail parser gives
> correct results - utf-8 bytes of 0xc5 0x91, which would've been placed
> into mysql over a connection using utf-8 encoding.
> 
> What I know is that reading it out of mysql over a utf-8 encoding gives
> a '?' (0x3f) for that character.  What I don't know is whether it's
> mysql having this behaviour, or whether your message was received with
> the character already converted to a '?'.
> 

Patches where send one by one with (smtp related options are omitted)

git send-email --suppress-cc=all --no-thread --to patches at armlinux.org.uk

If you want I can send a patch to you directly, so you can see if it
arrives converted or not.

Cheers
Vladimir
