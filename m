From: khilman@ti.com (Kevin Hilman)
Date: Thu, 06 Jan 2011 09:03:28 -0800
Subject: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
In-Reply-To: <BC214410FD04D84F9079A62423659707161C0C@008-AM1MPN1-003.mgdnok.nokia.com>
	(aaro koskinen's message of "Thu, 6 Jan 2011 10:15:50 +0000")
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com>
	<874o9mvpxf.fsf@ti.com>
	<BC214410FD04D84F9079A62423659707161C0C@008-AM1MPN1-003.mgdnok.nokia.com>
Message-ID: <87ei8qx8v3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<aaro.koskinen@nokia.com> writes:

> Hi,
>
> Kevin Hilman [khilman at ti.com]:
>> Aaro Koskinen <aaro.koskinen@nokia.com> writes:
>>
>> > Make !CONFIG_SUSPEND init declarations identical on all OMAPs and
>> > eliminate some ifdefs.
>> >
>> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
>>
>> I like this solution, but it introduces compiler warnings:
>>
>> [...]
>>
>> As you likely noticed, removing the const leads to checkpatch warnings:
>>
>> WARNING: struct platform_suspend_ops should normally be const
>>
>> so the choice is between a checkpatch warning or a bunch of compiler
>> warnings.
>>
>> Alternatively, I just posted a patch[1] to linux-pm propsing to fix this
>> at the source.  Let's see what happens there.  Merging $SUBJECT patch
>> will depend on how this is fixed upstream.
>
> Sorry, I should have mentioned this when I posted the patch. I was aware of
> this issue, but I thought this was already fixed in upstream. Check the following
> commit in linux-next:
>
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=2f55ac072f5344519348c0c94b3d2f4cca46847b
>
> (suspend: constify platform_suspend_ops)

ah, thanks.  somehow I missed that one when looking to see if this was
already fixed.

Kevin
