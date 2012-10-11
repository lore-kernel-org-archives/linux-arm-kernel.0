From: linux@prisktech.co.nz (linux at prisktech.co.nz)
Date: Fri, 12 Oct 2012 11:33:54 +1300 (NZDT)
Subject: [RFC PATCH] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <201210112029.05572.arnd@arndb.de>
References: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
 <201210110747.46682.arnd@arndb.de> <1349979450.16017.3.camel@gitbox>
 <201210112029.05572.arnd@arndb.de>
Message-ID: <57461.210.54.1.170.1349994834.squirrel@server.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thursday 11 October 2012, Tony Prisk wrote:
>> > config VT8500
>> >       bool "Via/Wondermedia VT8500 / WM8505 / WM8650" if ARCH_MULTIPLATFORM
>> >       default VT8500_SINGLE
>> >
>> >       Arnd
>>
>> Alexey (or anyone else),
>>
>> Do you want it kept in the meantime?
>>
>> I think the easiest way to add/keep it would be to create:
>>
>> ARCH_VT8500_SINGLE (arm/Kconfig) and ARCH_VT8500_MULTI
>> (arch-vt8500/Kconfig) and have them both select ARCH_VT8500 as an option
>> to make drivers available.
>
> You only need one new symbol, not too. Keeping CONFIG_VT8500 as the
> user-selectable option as I outlined in the example means that
> existing .config files keep working, which is sometimes useful.
>
> 	Arnd
>

To clarify what you said (because I'm not sure I got it the first time)...

Keep ARCH_VT8500 as the single-platform Kconfig option.
Add a new ARCH_VT8500_MULTI (for example) as the multiplatform Kconfig option.

Have ARCH_VT8500_MULTI select ARCH_VT8500??

The last bit confuses me (and seems a little backwards, although I suspect it
would work since none of the options would cause conflicts). Without ARCH_VT8500
selected, we have no driver options without changing all the Kconfig's.

If this is correct, we are basically using _MULTI to add more options on top of
_VT8500.

Am I close or did I completely misunderstand? :)

Regards
Tony P
