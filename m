From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 15 Feb 2013 14:16:26 -0500
Subject: randconfig errors
In-Reply-To: <c163151b4b855149ba57faa9a1a10c64@localhost>
References: <511E6FA4.2000709@gmail.com>
 <26e621467155fdb1626ecdac4e811deb@localhost>
 <c163151b4b855149ba57faa9a1a10c64@localhost>
Message-ID: <CANM98qKEwFzccifq6oWzzS4Ot_iaznccr9_CcQLDGhj_puS-Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 1:47 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Fri, 15 Feb 2013 19:22:37 +0100, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
>> On Fri, 15 Feb 2013 11:25:56 -0600, Rob Herring <robherring2@gmail.com>
>> wrote:
>>> Errors from randconfig builds restricted to multi-platform configs on
>>> the current linux-next. I know I've seen a fix on the first one from
>>> Arnd, but have not investigated any of these.
>>>
>>
>>>
>>
> /var/lib/jenkins/jobs/linux-randconfig/workspace/include/linux/kvm_host.h:333:34:
>>> error: 'KVM_USER_MEM_SLOTS' undeclared here (not in a function)
>>
>> This one comes from bbacc0c (KVM: Rename KVM_MEMORY_SLOTS ->
>> KVM_USER_MEM_SLOTS).
>> I'll queue a patch to fix the breakage...
>
> Looks like there's a few more, and what was brewing in kvm-next had some
> side effects.
>
> Christoffer, I'll send the patches separately.
>
I was kind of hoping that the KVM guys would have pulled the KVM/ARM
stuff into kvm/next and it could have been fixed up there.... The
patches are really trivial though iirc.
