From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 17 Mar 2011 11:15:23 -0500
Subject: [PATCH 2/3] ep93xx: add /proc/cpuinfo extension
In-Reply-To: <AANLkTi=7hmWOFZFg_-zT3EO3uwzOXKkR+pCroc3UUTOV@mail.gmail.com>
References: <AcrJ7vBVySpZbSYBQ1eQDb/9VrGf4Q==>
	<0D753D10438DA54287A00B02708426976368DDCD38@AUSP01VMBX24.collaborationhost.net>
	<AANLkTi=7hmWOFZFg_-zT3EO3uwzOXKkR+pCroc3UUTOV@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B027084269764D14AB617@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 16, 2011 8:30 PM, Martin Guy wrote:
>
> Just spotted an off-by-one error in this patch, if of very minor and
> unlikely effect.
>
> On 22 March 2010 19:39, H Hartley Sweeten <hartleys@visionengravers.com> wrote:

Cool.. I time traveled...

Actually, I submitted this last year.  I think Russell NAK'ed it at that time since
it modified the output of /proc/cpuinfo and he did not see a valid reason for it.

There is some discussion going on right now to add a "socinfo" to sysfs where this
information could be exposed.  When that gets worked out I will come up with a new
patch.

>> Add a callback to mach-ep93xx for the /proc/cpuinfo extension.
>>
>> This cpuinfo extension dumps the processor unique ID and Maverick
>> Key as well as the processor silicon revision and a number of
>> boot configuration options.
>> ...
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index 90fb591..fe1eb7a 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>>...
>> +static const char *ep93xx_rev[] = {
>> + ? ? ? "A", "B", "C", "D0", "D1", "E0", "E1", "E2", "??"
>> +};
>>...
>> + ? ? ? val = ep93xx_chip_revision();
>> + ? ? ? if (val > ARRAY_SIZE(ep93xx_rev))
>> + ? ? ? ? ? ? ? val = ARRAY_SIZE(ep93xx_rev) - 1;
>> + ? ? ? seq_printf(m, "Silicon Rev\t: %s\n", ep93xx_rev[val]);
>
> Shouldn't that be
>
> +       if (val >= ARRAY_SIZE(ep93xx_rev))
>

Regardless, if I remember correctly, someone already pointed this out.  I'll
keep it in mind when I re-do this patch based on the "socinfo" stuff.

Thanks,
Hartley
