From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 11 Nov 2015 17:10:46 -0800
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <20151105161756.GG3078@atomide.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com> <20151012201640.GQ23801@atomide.com>
 <201510122225.12786@pali> <20151012204509.GT23801@atomide.com>
 <20151013143746.GJ23104@pali> <20151105114041.GC27908@pali>
 <20151105161756.GG3078@atomide.com>
Message-ID: <5643E716.9080204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding devicetree list.

Thread starts at
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354459.html

On 11/5/2015 8:17 AM, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [151105 03:41]:
>> On Tuesday 13 October 2015 16:37:46 Pali Roh?r wrote:
>>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
>>>> * Pali Roh?r <pali.rohar@gmail.com> [151012 13:29]:
>>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
>>>>>>
>>>>>> Pali, any news on posting an updated series with the comments
>>>>>> addressed in this thread? It seems that we all pretty much agree
>>>>>> what needs to be done.

I'm not real happy with the concept of patches 4 and 5 in this series.
My concern is that those two patches are using the FDT as a transport
mechanism for a binary blob (the atags object).

Patches 1 and 2 do follow the spirit of atags_to_fdt() since an
atags kernel already may set system_rev from an atag.

-Frank


>>>>>
>>>>> Tony, I'm not really sure what to do. Just wrap 4 and 5 patches into 
>>>>> CONFIG_KEXEC? Or something more?
>>>>
>>>> Well for most part your patches are fine, I think there were some
>>>> minor comments on the series.
>>>>
>>>> For the CONFIG_KEXEC dependency, we should just keep the existing
>>>> behavior and keep /proc/atags behind CONFIG_KEXEC. That's all
>>>> I believe :)
>>>>
>>>> Regards,
>>>>
>>>> Tony
>>>>
>>>>
>>>
>>> Ok. I will add CONFIG_KEXEC into atag patches.
>>>
>>> And there is missing documentation for these two new DT properties
>>> (marked as TODO in commit messages). Where to put them?
>>>
>>
>> Tony (or somebody else) ^^^
> 
> How about Documentation/devicetree/bindings/arm/atags.txt?
> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
