From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Feb 2011 09:17:37 +0000
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <alpine.LFD.2.00.1102152257500.14920@xanadu.home>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
Message-ID: <AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 16, 2011 at 4:03 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 15 Feb 2011, vb at vsbe.com wrote:
>
>> hello all,
>>
>> I am trying to compile the 2.6.37 kernel in THUMB2 mode and am
>> experiencing some compilation problems. Some inline assembly in some
>> files uses commands inappropriate for THUMB2 mode.
>>
>> I wonder if the kernel is expected to compile cleanly when
>> CONFIG_THUMB2_KERNEL is enabled (and I am doing something wrong), or
>> is it know not to compile/work in Thumb2 node for any reason?
>
> It is known not to compile in mainline right now depending on your
> target, but fixes are slowly being merged upstream.
>
> Dave Martin is maintaining a Git tree with all the fixes required for
> Thumb2 here (see the Thumb2 related branches):
>
> http://git.linaro.org/gitweb?p=people/dmart/linux-2.6-arm.git;a=summary
>
> Beware that some patches might not be final yet.

Note that while the bulk of the kernel is Thumb-2 safe, there are
occasional regressions, and individual platforms and drivers could
still have problems.  For now, I've been focusing on omap--- see

git://git.linaro.org/people/dmart/linux-2.6-arm.git dirty/arm/omap-thumb2+merged

ARM: Add local symbols in relocate_kernel.S to work around gas bugs

If you're trying to support a specific board I'm unlikely to be able
to debug it for you, but feel free to ping me with questions.

Cheers
---Dave
