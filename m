From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Wed, 21 Jan 2015 00:05:53 +0100
Subject: [PATCH] arch: arm: mach-ux500: board-mop500-regulators.c: Remove
 unused function
In-Reply-To: <11128609.Upt8IQGP29@wuerfel>
References: <1420126805-28098-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5939350.DKrZ01egfS@wuerfel> <20150118180747.GK3574@x1>
 <11128609.Upt8IQGP29@wuerfel>
Message-ID: <CAKXHbyNkPGxgtzHW2Ee-wG2nnRdwcznECb-a_EPTYnjH+K0Jfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-19 11:00 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 18 January 2015 18:07:47 Lee Jones wrote:
>> On Fri, 02 Jan 2015, Arnd Bergmann wrote:
>>
>> > On Thursday 01 January 2015 16:40:05 Rickard Strandqvist wrote:
>> > > Remove the function mop500_regulator_init() that is not used anywhere.
>> > >
>> > > This was partially found by using a static code analysis program called cppcheck.
>> > >
>> > > Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> >
>> > This looks wrong: For one thing, you failed to notice that now another function
>> > in the same file becomes unused, or that half of the file is not used
>> > anyway.
>> >
>> > It also seems that the fact that this function is not called was an accident
>> > and it should in fact be called. Maybe Lee has some more insight in this,
>> > as he added the function in the first place.
>> >
>> > Finally (unrelated to your patch, but triggered by looking at it), I suspect
>> > we should just move the ab8500_regulator_plat_data and everything it references
>> > to drivers/regulator/ab8500-ext.c, because we only have one instance of it
>> > and won't ever have more.
>>
>> This is old code.  The development of this stuff was halted before it
>> could be finished.  Feel free to remove it and all other unused code
>> it uncovers.
>>
>
> Thanks for the confirmation!
>
> Richard, do you feel up to doing the task of the broader cleanup here?
>
>         Arnd



Hi

Yes, of course :)
Will see how much I can remove or move to
arch/arm/mach-ux500/cpu-db8500.c   like ab8500_regulator_plat_data.
And I believe there is more that I can do the same with.

So something is going on, but need a little more time...


Kind regards
Rickard Strandqvist
