From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 21 Apr 2011 13:55:58 +0900
Subject: [linux-pm] [TuxOnIce-devel] [RFC PATCH] Current status,
	suspend-to-disk support on ARM
In-Reply-To: <BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q@mail.gmail.com>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
	<BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ@mail.gmail.com>
	<alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
	<BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q@mail.gmail.com>
Message-ID: <BANLkTinXOR+AhsTtgLdnnmT=1Q4M5Q5LWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Matt,

On Wed, Apr 20, 2011 at 4:14 PM, Matt Hsu <matt@0xlab.org> wrote:
>
>>
>> Also, I'd like to investigate whether ARM will require a set of
>> platform_hibernation_ops - Samsung's patch from last December,
>>
>> http://www.spinics.net/lists/arm-kernel/msg108565.html
>
> ??? Hi FrankH,
>
> ???? The patch seems has connection with this
>
> ???? www.kernel.org/doc/ols/2010/ols2010-pages-9-18.pdf

Actually, those patches had no direct connections with that anyway. :)

>
> ? ? You can see the section 4.3 fast device reactivation.
> ? ? It does the similar thing? as STR, but drivers status are kept in
> hibernation image instead of main memory.
> ??? I guess this is why this patch comes out.

Yes, this SoC has registers that require STR/Hibernation to save the
status. They include power, clock, memory-control, gpio, uart related
registers.

>
> ??? In the current device driver model, there are no appropriate handling
> specific to
> ??? hibernation_suspend/hibernation_resume ops.
>
> ??? So they make their own interface/platform drivers.

Correct.

If the interface looks like dev_pm_ops, it would be virtually perfect. :)

>
>>
>> seems to indicate that they believe it's necessary at least on some ARM
>> hardware. OMAP has similar functions to that, it'd be great to unify.
>>
>>
>> FrankH.
>>
> --
> - Matt
>
> _______________________________________________
> linux-pm mailing list
> linux-pm at lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
