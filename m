From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 7 Nov 2011 18:12:58 -0700
Subject: [PATCH 2/3 RESEND] ARM: pxa: Add DT testing machine
In-Reply-To: <4EB85C83.1040701@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-3-git-send-email-marek.vasut@gmail.com>
 <4EB854BC.8020203@gmail.com>
 <201111072306.43015.marek.vasut@gmail.com> <4EB85C83.1040701@gmail.com>
Message-ID: <CACxGe6uJ0Pgo4-qMyNxDLifsWxd4zaykj-VgtqQu1ABcKp-g2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2011 at 3:32 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 11/07/2011 04:06 PM, Marek Vasut wrote:
>>>> +#ifndef ? ?CONFIG_MACH_VPAC_DT
>>>>
>>>> ?MACHINE_START(VPAC270, "Voipac PXA270")
>>>>
>>>> ? ? .atag_offset ? ?= 0x100,
>>>> ? ? .map_io ? ? ? ? = pxa27x_map_io,
>>>>
>>>> @@ -723,3 +724,4 @@ MACHINE_START(VPAC270, "Voipac PXA270")
>>>>
>>>> ? ? .timer ? ? ? ? ?= &pxa_timer,
>>>> ? ? .init_machine ? = vpac270_init
>>>>
>>>> ?MACHINE_END
>>>>
>>>> +#endif
>>>
>>> You shouldn't need this ifndef.
>>
>> For some reason, it refuses to boot if I do have both compiled in.
>>
>
> That doesn't really sound like a good reason. Perhaps you have initcalls
> which run unconditionally.

Yes, this is very important.  Turning on DT support must not break
non-DT support in the same kernel.  You must be able to configure both
into the kernel and then boot both with and without DT (assuming of
course that non-DT booting is supported already in the kernel).  The
reason for this is that it is a lot more friendly to debug DT support
when the same kernel can still be booted the old way after turning DT
on.  I am unlikely to be moved on this point.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
