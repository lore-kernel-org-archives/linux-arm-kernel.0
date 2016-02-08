From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 8 Feb 2016 10:17:09 -0600
Subject: [RFC PATCH 0/3] arm64 initrd mapping/relocation
In-Reply-To: <CAKv+Gu__xLKxwAXXf=C3VxpLizjP3oADYyk0bQzQT1G-gTxFqQ@mail.gmail.com>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160202180622.GP10166@arm.com> <1454509367.4108.3.camel@redhat.com>
 <CAKv+Gu__xLKxwAXXf=C3VxpLizjP3oADYyk0bQzQT1G-gTxFqQ@mail.gmail.com>
Message-ID: <56B8BF85.2060407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2016 08:26 AM, Ard Biesheuvel wrote:
> On 3 February 2016 at 15:22, Mark Salter <msalter@redhat.com> wrote:
>> On Tue, 2016-02-02 at 18:06 +0000, Will Deacon wrote:
>>> On Tue, Feb 02, 2016 at 06:56:39PM +0100, Ard Biesheuvel wrote:
>>>> After discussing in linux-efi with Mark, and on #armlinux with Will, this is
>>>> a proposal for dealing with initrd memory that is potentially not covered by
>>>> the linear region.
>>>>
>>>> Note that this will look slightly differently when some of the KASLR work gets
>>>> merged, but this should only affect the way we deal with the initrd if it sits
>>>> outside of the linear region.
>>>>
>>>> Mostly intended for discussion, not tested at all.
>>>
>>> Thanks Ard, this looks like a much better approach to me. Mark -- does
>>> the general idea work for you too?
>>>
>>> Will
>>
>> Yeah, much simpler. I like it in concept but am I missing something or is it
>> adding memory to the system beyond the mem= limit?
>
> Indeed. I think it is reasonable to require that if you pass both mem=
> and initrd= *and* you need your memory limit to be honored strictly,
> it is up to you to ensure that the initrd does not live in the memory
> you are throwing away.
>
>> But even that may not be
>> a big deal. And I need to look at the KASLR work and understand the issues
>> with it and mem= if any. I'm traveling right now and can't really try it out
>> until tomorrow...
>>
>
> No worries. My estimation is that Will is not going to take this as a
> fix anyway, so we have plenty of time to test and/or discuss


I needed these patches to successfully boot a JunoR2 with a recent 
tianocore firmware.

Thanks,
