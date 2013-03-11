From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 11 Mar 2013 08:58:52 -0700
Subject: [kvmarm] [GIT PULL v2] KVM/ARM Fixes for 3.9-rc1
In-Reply-To: <513DB41F.1010904@arm.com>
References: <CAEDV+gLpqG0GxbCDoUqO2fdwpqLeEd_psaaFWzm2Xi829-zUTQ@mail.gmail.com>
 <f3db22097ee303991fccc64bbf863dd6@localhost>
 <CAEDV+g+ATCr3Hd+VjwLW7tgbJ9Cq4eaC49ZFO-1jB=grAVR49w@mail.gmail.com>
 <fd46d1c4746530d6c705dba843c848ea@localhost>
 <20130307190900.GB15854@amt.cnet>
 <600b4cf22f05ccd66c8f6e18eaaf75c4@localhost>
 <CAEDV+gL_nMCw-1JK+L0W_X=T9q8gEo6xhC9trXHv84YjJ7OiGA@mail.gmail.com>
 <513DB41F.1010904@arm.com>
Message-ID: <CAEDV+gJAuVujPnZrtQSTvc7WPJ+iD4c6u9b2Pm32KQPYP8ek5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 3:38 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 08/03/13 19:26, Christoffer Dall wrote:
>> On Thu, Mar 7, 2013 at 7:12 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On Thu, 7 Mar 2013 16:09:00 -0300, Marcelo Tosatti <mtosatti@redhat.com>
>>> wrote:
>>>> On Thu, Mar 07, 2013 at 07:57:23AM +0100, Marc Zyngier wrote:
>>>>> On Wed, 6 Mar 2013 20:40:00 -0800, Christoffer Dall
>>>>> <cdall@cs.columbia.edu>
>>>>> wrote:
>>>>>> On Wed, Mar 6, 2013 at 7:54 PM, Marc Zyngier <marc.zyngier@arm.com>
>>>>> wrote:
>>>>>>> On Wed, 6 Mar 2013 16:31:48 -0800, Christoffer Dall
>>>>>>> <cdall@cs.columbia.edu>
>>>>>>> wrote:
>>>>>>>
>>>>>>> Hi Christoffer,
>>>>>>>
>>>>>>>>
>>>>>>>> Please pull these KVM/ARM fixes mostly centered around preparation
>>>>>>>> for
>>>>>>>> Marc's ARMv8 KVM work.
>>>>>>>
>>>>>>> Can we please hold on that for a while? asm-offset.c is usually a
>>>>>>> candidate for merge conflicts as people start pushing patches post
>>>>> merge
>>>>>>> window, and it would make sense to see what is happening in that
>>>>>>> space.
>>>>>>>
>>>>>> Sure, when would you see this happen exactly?
>>>>>
>>>>> Usually, by -rc5 we have a pretty good idea of what is going in. Also,
>>>>> putting things into -next is a good way to detect potential problems.
>>>>>
>>>>> Oh, and keeping linux-arm-kernel into the loop. Most ARM developers
>>> don't
>>>>> follow the KVM lists.
>>>>>
>>>>>         M.
>>>>
>>>> Mark, can you please be more verbose on the reason for this request?
>>>
>>> arch/arm/kernel/asm-offset.c, being an ARM core file, is often the
>>> location of merge conflicts. And because arch/arm sees a lot more churn
>>> than any other architecture, we have the policy of dealing with conflicts
>>> before they hit Linus.
>>>
>>> We usually deal with that by providing stable branches that will contain
>>> the "offending" patches, and on which others can base their developments.
>>>
>>> This is why I suggested holding on this pull request until we got a better
>>> view of what potential merge conflicts we get with this patches. This
>>> shouldn't prevent the patches from entering -next though, as this would
>>> help detecting the above conflicts.
>>>
>> So I think you need to explain me a little more carefully how the
>> 'usually' applies in this case. This is just a pull request to the
>> kvm/master branch - it's not to Linus or ARM-specific. The only thing
>> is that we touch asm-offsets.c.
>
> Yes, and that's the issue. Core changes to the ARM code usually goes
> through RMK in order to avoid conflicts. This is a long established
> policy. It could be another tree (arm-soc, for example), but that's the
> general idea.
>
> At least getting an Ack from Russell so he knows about this patch seems
> to be the minimum we could do.
>
>> The only thing I can see that happens here is:
>>  - merge to kvm/master
>>  - kvm/master gets merged by Linus into -rcX (he fixes any merge
>> conflicts if present)
>
> And that's exactly what we've worked very hard to avoid. We don't let
> conflicts go up to Linus.
>
>>  - we, ARM, kvm, everyone, pull back from Linus
>>
>> and that's it.
>>
>> Perhaps it would be helpful if you can explain the situation we need
>> to avaoid and what exactly is the scenario when this breaks?
>>
>> The merge conflicts in asm-offsets.c should be uber-trivial, so I'm
>> not sure what the big deal is.
>
> Given that we don't know what is to be merged yet, your crystal ball is
> as good as mine.
>
> Anyway, I've said it. In the end, this is your decision as a maintainer.
>
I certainly appreciate your input, and I definitely want to do this in
a way that makes the community happy, I'm just a bit confused about
exactly how the process should go, and I still don't quite see what
sending a pull request at -rc5 will give us. Maybe I'm being slow?

Otherwise, it sounds like I should simply send Russel a pull-request
for a specific branch made off one of his stable branches?

Is there an established branch to use or workflow (perhaps even
documented somewhere that I can look at), or do I have to send Russell
an e-mail requesting a stable branch and base my pull request off
there, or does something automagically happen at rc5?

-Christoffer
