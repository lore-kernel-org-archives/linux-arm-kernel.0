From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 25 Aug 2014 08:32:01 -0700
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
In-Reply-To: <CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
 (Chander Kashyap's message of "Mon, 25 Aug 2014 17:45:07 +0530")
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
 <53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
 <7hbnrc6px3.fsf@paris.lan> <53F7DA13.6090305@gmail.com>
 <CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
Message-ID: <7h8umc60we.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

Chander Kashyap <k.chander@samsung.com> writes:

[...]

>>> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
>>> testing along with CPUidle, so there may be some untested interactions
>>> there as it seems a bit more stable without CPUidle enabled.
>>>
>>> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
>>> together big.LITTLE 5420/5800, with or without the switcher.
>
> I have tested this patch series on SMDK5420 with cpuidle (with and
> without b.L switcher enabled).
>
> As of now voltage scaling support is not there in generic big-little
> cpufreq driver (arm_big_little.c).
> Hence need to tie arm and kfc voltages to highest level for testing.

> Without this change stability issues are there, but with this change
> everything is stable.

Can you clarify how you're setting the voltages to ensure stability?

Tomasz, I didn't mean to suggest this isn't ready for mainline.  For the
5420/5800 it seems cpufreq support is a new feature, so this isn't a
regression against previous (mainline) behavior.  Maybe the big.LITTLE
cpufreq support should've been separated out from the cleanup since it's
more of a new feature, but that's up to you.

Kevin
