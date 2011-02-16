From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Feb 2011 09:19:46 +0000
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
Message-ID: <AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 9:17 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Hi,
>
> On Wed, Feb 16, 2011 at 4:03 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Tue, 15 Feb 2011, vb at vsbe.com wrote:
>>
>>> hello all,
>>>
>>> I am trying to compile the 2.6.37 kernel in THUMB2 mode and am
>>> experiencing some compilation problems. Some inline assembly in some
>>> files uses commands inappropriate for THUMB2 mode.
>>>
>>> I wonder if the kernel is expected to compile cleanly when
>>> CONFIG_THUMB2_KERNEL is enabled (and I am doing something wrong), or
>>> is it know not to compile/work in Thumb2 node for any reason?
>>
>> It is known not to compile in mainline right now depending on your
>> target, but fixes are slowly being merged upstream.
>>
>> Dave Martin is maintaining a Git tree with all the fixes required for
>> Thumb2 here (see the Thumb2 related branches):
>>
>> http://git.linaro.org/gitweb?p=people/dmart/linux-2.6-arm.git;a=summary
>>
>> Beware that some patches might not be final yet.
>
> Note that while the bulk of the kernel is Thumb-2 safe, there are
> occasional regressions, and individual platforms and drivers could
> still have problems. ?For now, I've been focusing on omap--- see
>
> git://git.linaro.org/people/dmart/linux-2.6-arm.git dirty/arm/omap-thumb2+merged
>
> ARM: Add local symbols in relocate_kernel.S to work around gas bugs

^ Oops, forgot to explain that line: this is the patch required to
work around a specific bug in the assembler.  I'm not currently
proposing to merge this upstream, since I prefer the assembler to get
fixed...
You can grab this patch from the branch.

>
> If you're trying to support a specific board I'm unlikely to be able
> to debug it for you, but feel free to ping me with questions.
>
> Cheers
> ---Dave
>
