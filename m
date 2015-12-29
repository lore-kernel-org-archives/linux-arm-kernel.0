From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Dec 2015 13:48:52 +0000
Subject: [PATCH] ARM: mm: Enable PXN when running non-LPAE kernel on LPAE
In-Reply-To: <1451341389.25978.39.camel@decadent.org.uk>
References: <005201d1415a$e5fe5ed0$b1fb1c70$@samsung.com>
 <1451341389.25978.39.camel@decadent.org.uk>
Message-ID: <56828F44.9030204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/12/15 22:23, Ben Hutchings wrote:
> On Mon, 2015-12-28 at 19:31 +0900, Jungseung Lee wrote:
>> 2015-05-11 23:36 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
>>> On Mon, May 11, 2015 at 05:09:35PM +0900, Jungseung Lee wrote:
>>>> Hi, Ben.
>>>>
>>>> 2014-12-25 2:20 GMT+09:00 Catalin Marinas :
>>>>> On Wed, Dec 24, 2014 at 03:54:28PM +0000, Ben Hutchings wrote:
>>>>>> The VMSA field of MMFR0 (bottom 4 bits) is incremented for each
>>>>>> added feature.  PXN is supported if the value is >= 4 and LPAE
>>>>>> is supported if it is >= 5.
>>>>>>
>>>>>> In case a kernel with CONFIG_ARM_LPAE disabled is used on a
>>>>>> processor that supports LPAE, we can still use PXN in short
>>>>>> descriptors.  So check for >= 4 not == 4.
>>>>>>
>>>>>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>>>>>> Cc: Jungseung Lee <js07.lee@gmail.com>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>
>>>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>
>>>> Is this patch handled?
>>>
>>> If it's not in mainline already, than it probably isn't handled.
>>>
>>>> or you can send it to Russell's patch system:
>>>> http://www.arm.linux.org.uk/developer/patches/
>>>
>>> Check mainline first, otherwise please submit it.
>>>
>>
>>> --
>>> Catalin
>>
>> Hi, Ben
>>
>> It looks still not submitted yet. Could you send it to Russell's patch
>> system?
>> http://www.arm.linux.org.uk/developer/patches/
>>
> 
> I've never needed to use a web-based system to submit kernel patches
> before, and I'm not going to start now.  Someone else can re-submit

You don't have to... I just quote Catalin's recipe [1]

> You can send patches as usual to patches at arm.linux.org.uk, just add
> KernelVersion: v3.?? after the --- line in your patch (maybe this could
> be automate as well but I didn't bother).
> 
> For series, because the arrival order is not guaranteed, I use the git
> alias below to trick it into sleeping 60s between patches:
> 
> ksend-rmk-patch = !git send-email --annotate --no-thread --suppress-cc=all --to-cmd='sleep 60 && echo patches at arm.linux.org.uk "#"'
> 
> For stgit, I have a dedicated template:
> 
> From: %(sender)s
> To: patches at arm.linux.org.uk
> Subject: %(prefix)s%(shortdescr)s
> 
> %(longdescr)s
> PATCH FOLLOWS
> KernelVersion:%(version)s
> %(diff)s
> 
> And there is always git pull request that Russell is happy with.

Does it work for you?

[1] https://lkml.org/lkml/2014/8/22/228

Happy NY
Vladimir

> this if they want it.
> 
> Ben.
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
