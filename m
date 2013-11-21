From: olof@lixom.net (Olof Johansson)
Date: Thu, 21 Nov 2013 10:51:09 -0800
Subject: [PATCH v10 0/7] ARM: support for Trusted Foundations secure
 monitor
In-Reply-To: <528E5596.7090606@wwwdotorg.org>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
 <52828EF5.6090909@wwwdotorg.org>
 <CAOesGMhatp9ZQr=eTCtQ_9a_E9LXKdTCzJd+P7Sy9Ut9wtvnsA@mail.gmail.com>
 <5282E068.1070608@nvidia.com>
 <CAOesGMgcvTFD4u9b7T5HNhuJe_PQyV25Ei++v8hG8AsY_rOdyw@mail.gmail.com>
 <528E5596.7090606@wwwdotorg.org>
Message-ID: <CAOesGMgB_FUDkD9=wgZgreaspEyKoSqpkpGZtzuUjb=G6m_nEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 21, 2013 at 10:48 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> (Russell, a question for you at the bottom)
>
> On 11/13/2013 10:57 AM, Olof Johansson wrote:
>> On Tue, Nov 12, 2013 at 6:14 PM, Alex Courbot <acourbot@nvidia.com> wrote:
>>> On 11/13/2013 05:38 AM, Olof Johansson wrote:
> ...
>>>> I pinged Russell, and he brought up the fact that there were earlier
>>>> requests to move it to drivers/firmware. It would make sense to try to
>>>> get that done before merging, especially if you anticipate someone
>>>> using TF on 64-bit platforms.
>>>
>>> IIRC when we discussed this point your last comment was as follows:
>>
>> Touche. :) Thanks for the reminder.
>>
>>> On Tue, Oct 29, 2013 at 6:55 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> I think we can probably merge this under arch/arm now, and when we
>>>> figure out what needs to be common with ARM64 we can move it out to a
>>>> good location. It might be that mostly just a header file with ABI
>>>> conventions needs to be shared, not actual implementation, for
>>>> example.
>>>
>>> So I thought we agreed on that. If in the end we prefer to move the ARM
>>> firmware interface into drivers/firmware, I'm fine with that too (Tomasz
>>> also confirmed he would be ok with it) but I wonder if that would not be
>>> somehow premature.
> ...
>> Well, as I already said I'm ok with things going into arch/arm to
>> start with, as long as Russell is.
> ...
>
> Russell, the patch Alex sent to move firmware_ops into drivers/firmware
> was rejected, so I don't think we can update this series to move the
> code there instead.
>
> So, are you OK with merging this series as-is, in arch/arm/firmware? If
> you could ack the patch/series to indicate that, it would be awesome.

Sorry, this was stuck on my to-read-and-reply list.

I think merging for arch/arm is what makes sense here, even if we end
up at some point in the future moving it out. Only time will tell if
that makes sense or not, and it's not going to be a big deal to handle
at that time.

An ack from Russell would be appreciated, or we'd need to set up a
shared branch given the Tegra dependencies that would go on top.
Either is ok with me.


-Olof
