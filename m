From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Oct 2011 09:44:34 -0700
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <201110141827.53906.arnd@arndb.de>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
	<201110141827.53906.arnd@arndb.de>
Message-ID: <CAOesGMgDwMeVmwo1WJ3tU+ZdjCSJ6F8mY42e_KwTmzAkGQsqmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 9:27 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 14 October 2011, Stephen Warren wrote:
>> Arnd Bergmann wrote at Friday, October 14, 2011 9:30 AM:
>> ...
>> > You mention that tegra30 will require AUTO_ZRELADDR.
>>
>> Well, just to be clear, here's the situation I think:
>>
>> Tegra20's SDRAM starts at physical address 0.
>>
>> Tegra30's SDRAM starts at physical address 2G.
>>
>> To support that, we could either:
>>
>> a) Introduce a new Kconfig variable for Tegra30, make T20/T30 mutually
>> exclusive, and update arch/arm/mach-tegra/Makefile.boot to set zreladdr
>> etc. based on the new Tegra30 config variable too. Then, there's no need
>> for AUTO_ZRELADDR anywhere.
>>
>> b) Have no new config variable, build a unified T20/T30 kernel, leave
>> Makefile.boot untouched, and rely on using AUTO_ZRELADDR for Tegra30 to
>> account for the different SDRAM physical addresses.
>
> Ok, thanks for the explanation, that makes it much clearer. For
> completeness, you could also do both of the above and make T20/T30 mutually
> exclusive unless AUTO_ZRELADDR is set. That might be more complex than
> necessary, I don't know.

That is likely to get messy.

Seems like there could be some use for a (silent) option for a
platform to indicate that it can do XIP kernel (or zImage), and thus
not able to use AUTO_ZRELADDR (or other options that require rewriting
text segment of zImage or kernel).

Language gets awkard though, since it'd be a negative option (or all
platforms would need to add it). MACH_XIP_UNSUPPORTED perhaps?


-Olof
