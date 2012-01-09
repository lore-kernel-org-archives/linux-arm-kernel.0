From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Jan 2012 12:19:17 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <201201061730.33525.arnd.bergmann@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org>
Message-ID: <4F0ACD35.1000600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/2012 06:30 PM, Arnd Bergmann wrote:
> On Friday 06 January 2012, Daniel Lezcano wrote:
>> Move the location of the pm.h header file to the include directory,
>> so it can be included from another place from the current one.
>>
>> That will allow the next patch which moves the cpuidle code to the
>> drivers/cpuidle directory.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} |    0
>>  arch/arm/mach-at91/cpuidle.c                       |    2 +-
>>  arch/arm/mach-at91/pm.c                            |    2 +-
>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>  rename arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} (100%)
> 
> Moving the driver is great, as we have previously discussed, but
> the header file does not belong into include/asm really, because it
> is too hardware specific and we are trying to keep such stuff out
> of that place.

Hi Arnd,

I just want to clarify because I am not sure there is no confusion here
where the header will be moved to. The diff annotation is not clear and
suggests the file is moved to "next/include/asm".

Actually, the header moves from :

	arch/arm/mach-at91/pm.h
to:
	arch/arm/include/asm/at91_pm.h.

This place and the renaming of the file complies with the comments of
Russell, where this place is shared across the different ARM
architectures, Rob where the file is renamed for a single kernel image
and you where the cpuidle driver is moved to the drivers directory.
Looking at different drivers, it appears that is the case for the other
drivers.

For instance:

i7300_idle.c includes arch/x86/include/asm/idle.h
intel_idle.c includes arch/x86/include/asm/msr.h

So, from my POV, that makes sense to move pm.h to this directory, no ?

Thanks
  -- Daniel



- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPCs01AAoJEAKBbMCpUGYABb4IAMUuSl8Q0s6cKr8E7sgTGp3F
r758UVNTYR5X4AX67kmBRDeQGvnG/yifFAmTZ31G6fk5NKLuUMm6giiXua83PYfV
KvOKX30JHtqYhutcZyYemMTm5fgS1PbRmjEvEillaP9W7/SiKmg3hoOpPXPFW1k7
8Td6rN3SosCblBYcmq0BMqb3oHwjEXnfBJmkxELA37I5J6D33X8v4YUJ0QYANlcp
MK8yNg3U6IAqLXAa8jvzWVbDLwaewj+kYkHwr4cFCBLnX5mKuBx387AsA8GD6dzt
VmvoAi2PyX5D6hmSX58CVxHKnjke+iOsDKU9jWhwVRccPNrnstl1DlINknvZnk4=
=1otd
-----END PGP SIGNATURE-----
