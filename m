From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 04 Jan 2012 10:17:39 +0100
Subject: [RFC PATCH 0/8] Add common ARM cpuidle init code
In-Reply-To: <201201031602.01072.arnd.bergmann@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <201112081537.04789.arnd.bergmann@linaro.org> <4F031698.4010501@linaro.org>
 <201201031602.01072.arnd.bergmann@linaro.org>
Message-ID: <4F041933.70506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/2012 05:02 PM, Arnd Bergmann wrote:
> On Tuesday 03 January 2012, Daniel Lezcano wrote:
>> drivers/idle/intel_idle.c => drivers/cpuidle/intel.c
>> drivers/acpi/processor_idle.c => drivers/cpuidle/acpi.c
>>
>> arch/arm/mach-omap2/cpuidle34xx.c => drivers/cpuidle/omap-34xx.c
>> arch/arm/mach-omap2/cpuidle44xx.c => drivers/cpuidle/omap-44xx.c
>> arch/arm/mach-shmobile/cpuidle.c  => drivers/cpuidle/arm-shmobile.c
>> arch/arm/mach-davinci/cpuidle.c => drivers/cpuidle/davinci.c
>> arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/at91.c
>> arch/arm/mach-s3c64xx/cpuidle.c => drivers/cpuidle/s3c64xx.c
>> arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/exynos.c
>> arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/kirkwood.c
>> arch/arcm/mach-msm/idle.S => drivers/cpuidle/msm.S
>>
>> That could be a first step and then we move the other archs which could 
>> be a bit more tricky like the powerpc.
>>
>> Does it make sense ?
> 
> Sounds good to me. However, if any of the drivers can be built as
> loadable modules, or if there is any intention to make them so,
> the file name should be globally unique and follow a common naming
> scheme, e.g. idle-intel.c, idle-acpi.c, ...

Makes sense.

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

iQEcBAEBAgAGBQJPBBkzAAoJEAKBbMCpUGYAGoYH/3rFgCMaMXk71dEmm19gsq3l
FtSRbqeP+OXT+yDEaOG8cQr807Bn899WQrj6UY6gyRTHVPqlaPa4kKi09Jsn90BX
NMVVs4NyzZUrbV0Bofdw8D2Y2cMmVCs8xZfaU4FXa7eOvxEzSQImJVZhNvE8aGB3
b2h1r6Pp0fwXzJqJVvNRdzo49OONn/9l70YLf1pcimLpsmV/P3K5RTcTWMaYbuGW
FOudqawFQ8xDG7lQPMT4/kiVbHXNKq1VeDZvmenVvXdg0kRm9ptJ3kV4e5TrO1lO
RsiZAQiUn2NMt7RHZJimLzTd2ZXl3U2sQbRYbfe35VonSy8DjiCNkbjefVBj/JM=
=fVpl
-----END PGP SIGNATURE-----
