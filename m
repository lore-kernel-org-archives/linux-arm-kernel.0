From: vb@vsbe.com (vb at vsbe.com)
Date: Thu, 17 Feb 2011 09:30:01 -0800
Subject: compiling 2.6.37 kernel in THUMB2 mode
In-Reply-To: <AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
References: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
	<alpine.LFD.2.00.1102152257500.14920@xanadu.home>
	<AANLkTinQzK=s_r+_uaNRkq4MTPcF4zVE2aHPx5cqwYAN@mail.gmail.com>
	<AANLkTi=PLJBZ=Q-4k8ZUbX4S3w7f3WfUd9acb7iVYGBP@mail.gmail.com>
	<AANLkTi=_=jzs+MrvGbwF3L0c_eSq4nnbqE-xZ_+Z5fgH@mail.gmail.com>
	<AANLkTinKhCG4HauFHrPd=qr9vmVheH59vu2Be=tWoJft@mail.gmail.com>
Message-ID: <AANLkTik1FY=K1Wuo=vnh5xuq6aS1x2d2Km=ByrCSufJC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 1:27 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Hi,
>
> On Thu, Feb 17, 2011 at 2:02 AM, ?<vb@vsbe.com> wrote:
>> On Wed, Feb 16, 2011 at 1:19 AM, Dave Martin <dave.martin@linaro.org> wrote:
>>>>
>>>> Note that while the bulk of the kernel is Thumb-2 safe, there are
>>>> occasional regressions, and individual platforms and drivers could
>>>> still have problems. ?For now, I've been focusing on omap--- see
>>>>
>>>> git://git.linaro.org/people/dmart/linux-2.6-arm.git dirty/arm/omap-thumb2+merged
>>>>
>>>> ARM: Add local symbols in relocate_kernel.S to work around gas bugs
>>>
>>> ^ Oops, forgot to explain that line: this is the patch required to
>>> work around a specific bug in the assembler. ?I'm not currently
>>> proposing to merge this upstream, since I prefer the assembler to get
>>> fixed...
>>> You can grab this patch from the branch.
>>>
>>
>> Dave, thank you for this information. I checked out this branch and
>> would like to build a kernel. I don't know what omap is though, can
>> you please share a config file one could use to build the thumb
>> enabled kernel for it?
>
> OMAP is one of TI's applications processor families.
>
> From the developer perspective, people are using platforms like the
> Beagle or Panda boards
>
> http://www.beagleboard.org/
> http://www.pandaboard.org/
>
> But there are also many other variants, including boards made by
> third-party companies such as IGEPv2
>
> Are you targeting a specifc platform?
>

Hi Dave,

thank you again for the hints.

I am trying to build an image for a Tegra2 based platform, it s a
2.6.37 based tree with a fair amount of private additions (to be
upstreamed at some point), which does now come up and run in ARM mode.
I am trying to see if it can run in Thumb mode.

It looks like certain files need to be compiled in ARM mode even when
THUMB2_KERNEL is enabled, but I don't see this happening in 2.6.37, I
was wondering how this is done in your tree.

I tried building an OMAP image, but it does not build in Thumb mode,
and Thumb can't even be enabled for it because CPU_V6 configured in.
So I was wondering if this tree has some other working config which
does use Thumb mode. I'll look at the config files you mentioned, but
any suggestions/warnings about converting a kernel to work in Thumb
mode are welcome,

cheers,
/v

>
> There's a config file here, which should build a kernel which works on
> the Beagle or Panda board:
> http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config
>
> Note that you may hit a section discard problem when the final link is
> done to create vmlinux. ?The top patch from this branch should work
> around it, but hopefully it should be fixed upstream soon:
>
> git://git.linaro.org/people/dmart/linux-2.6-arm.git
> arm/smpup-section-discard-fix
>
> Cheers
> ---Dave
>
>>
>> TIA,
>> cheers,
>> Vadim
>>
>>
>>
>>>>
>>>> If you're trying to support a specific board I'm unlikely to be able
>>>> to debug it for you, but feel free to ping me with questions.
>>>>
>>>> Cheers
>>>> ---Dave
>>>>
>>>
>>
>
