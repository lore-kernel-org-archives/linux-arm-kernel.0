From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Mar 2013 10:21:39 +0000
Subject: [kvmarm] [GIT PULL v2] KVM/ARM Fixes for 3.9-rc1
In-Reply-To: <20130308113150.GF24444@redhat.com>
References: <CAEDV+gLpqG0GxbCDoUqO2fdwpqLeEd_psaaFWzm2Xi829-zUTQ@mail.gmail.com>
 <f3db22097ee303991fccc64bbf863dd6@localhost>
 <CAEDV+g+ATCr3Hd+VjwLW7tgbJ9Cq4eaC49ZFO-1jB=grAVR49w@mail.gmail.com>
 <fd46d1c4746530d6c705dba843c848ea@localhost>
 <20130307190900.GB15854@amt.cnet>
 <600b4cf22f05ccd66c8f6e18eaaf75c4@localhost>
 <20130308113150.GF24444@redhat.com>
Message-ID: <513DB033.9040006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/13 11:31, Gleb Natapov wrote:
> On Fri, Mar 08, 2013 at 04:12:41AM +0100, Marc Zyngier wrote:
>> On Thu, 7 Mar 2013 16:09:00 -0300, Marcelo Tosatti <mtosatti@redhat.com>
>> wrote:
>>> On Thu, Mar 07, 2013 at 07:57:23AM +0100, Marc Zyngier wrote:
>>>> On Wed, 6 Mar 2013 20:40:00 -0800, Christoffer Dall
>>>> <cdall@cs.columbia.edu>
>>>> wrote:
>>>>> On Wed, Mar 6, 2013 at 7:54 PM, Marc Zyngier <marc.zyngier@arm.com>
>>>> wrote:
>>>>>> On Wed, 6 Mar 2013 16:31:48 -0800, Christoffer Dall
>>>>>> <cdall@cs.columbia.edu>
>>>>>> wrote:
>>>>>>
>>>>>> Hi Christoffer,
>>>>>>
>>>>>>>
>>>>>>> Please pull these KVM/ARM fixes mostly centered around preparation
>>>>>>> for
>>>>>>> Marc's ARMv8 KVM work.
>>>>>>
>>>>>> Can we please hold on that for a while? asm-offset.c is usually a
>>>>>> candidate for merge conflicts as people start pushing patches post
>>>> merge
>>>>>> window, and it would make sense to see what is happening in that
>>>>>> space.
>>>>>>
>>>>> Sure, when would you see this happen exactly?
>>>>
>>>> Usually, by -rc5 we have a pretty good idea of what is going in. Also,
>>>> putting things into -next is a good way to detect potential problems.
>>>>
>>>> Oh, and keeping linux-arm-kernel into the loop. Most ARM developers
>> don't
>>>> follow the KVM lists.
>>>>
>>>>         M.
>>>
>>> Mark, can you please be more verbose on the reason for this request? 
>>
>> arch/arm/kernel/asm-offset.c, being an ARM core file, is often the
>> location of merge conflicts. And because arch/arm sees a lot more churn
>> than any other architecture, we have the policy of dealing with conflicts
>> before they hit Linus.
>>
>> We usually deal with that by providing stable branches that will contain
>> the "offending" patches, and on which others can base their developments.
>>
> Can you elaborate on that? If all changes to arch/arm/kernel/asm-offset.c not
> go through the same tree how having many stable branches solve conflicts
> issues?

Patches for the conflicting file go to a stable branch (usually in RMK's
tree), and everyone else bases their own branch on the stable one.

	M.
-- 
Jazz is not dead. It just smells funny...
