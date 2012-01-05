From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 05 Jan 2012 10:46:48 +0100
Subject: [PATCH 1/2][RFC] at91 : move pm.h header to include/mach
In-Reply-To: <20120104221036.GK11810@n2100.arm.linux.org.uk>
References: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
 <4F048CD9.1050601@gmail.com> <20120104221036.GK11810@n2100.arm.linux.org.uk>
Message-ID: <4F057188.8080101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/04/2012 11:10 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 04, 2012 at 11:31:05AM -0600, Rob Herring wrote:
>> This header should probably be named something more specific like
>> at91_pm.h or at91_sdram.h. This will be needed to avoid name collisions
>> with mach headers on a single kernel binary.
> 
> I think actually the idea that mach/*.h headers can be included by stuff
> outside of arch/arm is something that we should deprecate, because it's
> not going to be sane to make them all unique in this way.
> 
> Not only that but it prevents the .c files being built on other
> architectures, and provides another reason why the .c file is tied to
> a pariticular SoC - even if the same IP is used in a different SoC, it
> can be used as a reason why not to reuse the .c file.
> 
> Let's not give people excuses not to share code!

As the pm.h file should be included from drivers/cpuidle/at91_idle.c,
does it make sense to move
	arch/arm/mach-at91/pm.h to arch/arm/include/asm/at91_pm.h ?

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

iQEcBAEBAgAGBQJPBXGIAAoJEAKBbMCpUGYAUFoH/izNX5+7lZV33aZGERypoBHW
+3WRyAEhiMJPDAEYTDKxXyN4jz9177qEUfJXPpzA9+UZpoVKH6JHONbbzPMIFXf6
cj0lG6VrZh6ntDxFvZ531sCghqy6u75YYfTrJflrijsKAtBbv6OVOrTVnoOqZLn8
HG1noRNz4cey5JgzO627grQBt4UCWYGs/+gNr1H0K5AqjCjyUdSuPFQwSEUotPki
7tV54U+ba4jm2xbhRjARSjeMJh5EVCiVOnYjkJbOYWE0xEODOQKglKk8ptG/9GUT
AVzBb4kGZu5DFD0Q8JZvArLjowB27jRmTnHwsCiOB3HwuZMmhXy5ntV7GYiTRwI=
=LHB3
-----END PGP SIGNATURE-----
