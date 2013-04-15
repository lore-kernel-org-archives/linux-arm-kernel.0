From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 15 Apr 2013 16:29:02 +0200
Subject: [RFC patch 2/2] ARM: at91: cpuidle: move the driver to
 drivers/cpuidle directory
In-Reply-To: <516C0B30.501@atmel.com>
References: <1366032598-23053-1-git-send-email-daniel.lezcano@linaro.org>
 <1366032598-23053-3-git-send-email-daniel.lezcano@linaro.org>
 <516C0B30.501@atmel.com>
Message-ID: <516C0EAE.10804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2013 04:14 PM, Nicolas Ferre wrote:
> On 04/15/2013 03:29 PM, Daniel Lezcano :
>> We don't have any dependency with the SoC specific code.
>>
>> Move the driver to the drivers/cpuidle directory.
>>
>> Add Nicolas Ferre as author of the driver, so it will be in copy of the emails.
> 
> Unfortunately, I am not the author of this driver. It is the work of
> Albin Tonnerre <albin.tonnerre@free-electrons.com>. So, for sure, I (and
> Jean-Christohpe) can babysit this code but I cannot be awarded for it...
> You can certainly add to the header of this file:
> Maintained by the AT91 crew: Nicolas Ferre, Jean-Christophe
> Plagniol-Villard (together with email addresses).

Ok, will do.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-at91/Makefile  |    1 -
>>  arch/arm/mach-at91/cpuidle.c |   55 ----------------------------------------
>>  drivers/cpuidle/Makefile     |    1 +
>>  drivers/cpuidle/at91.c       |   57 ++++++++++++++++++++++++++++++++++++++++++
> 
> No, sorry this file name is not appropriate: I prefer cpuidle-at91.c

Sure ? :)

It is a bit redundant drivers/cpuidle/cpuidle-at91.c, no ? and if all
the cpuidle drivers are there, the directory content will look:

cpuidle/cpuidle-tegra114.c
cpuidle/cpuidle-tegra20.c
cpuidle/cpuidle-tegra30.c
cpuidle/cpuidle-imx5.c
cpuidle/cpuidle-imx6.c
cpuidle/cpuidle-kirkwood.c
cpuidle/cpuidle-calxeda.c
cpuidle/cpuidle-shmobile.c
cpuidle/cpuidle-intel-idle.c
cpuidle/cpuidle-at91.c
cpuidle/cpuidle-omap34xx.c
cpuidle/cpuidle-omap44xx.c
cpuidle/cpuidle-ux500.c
cpuidle/cpuidle-exynos4.c
cpuidle/cpuidle-acpi.c
cpuidle/cpuidle-pseries.c
cpuidle/cpuidle-sh.c
cpuidle/cpuidle-s3c64xx.c
cpuidle/cpuidle-davinci.c

etc ...

But I won't argue if you really want cpuidle-at91.c, it is a detail IMO.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
