From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Fri, 6 Jan 2012 17:30:33 +0000
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <201201061730.33525.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 January 2012, Daniel Lezcano wrote:
> Move the location of the pm.h header file to the include directory,
> so it can be included from another place from the current one.
> 
> That will allow the next patch which moves the cpuidle code to the
> drivers/cpuidle directory.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} |    0
>  arch/arm/mach-at91/cpuidle.c                       |    2 +-
>  arch/arm/mach-at91/pm.c                            |    2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} (100%)

Moving the driver is great, as we have previously discussed, but
the header file does not belong into include/asm really, because it
is too hardware specific and we are trying to keep such stuff out
of that place.

One option would be to move the pm.c along with the cpuidle.c file,
in particular that might turn out to be a good idea if other
platforms have the same requirement.

Aside from that, it would be good to hear from the AT91 maintainers
how they want to deal with the removal of CONFIG_ARCH_AT91_*
conditionals, which AFACIT will be necessary anyway in order to allow
building a single kernel across multiple at91 targets. Once that
problem is solved for pm.h, the question of where to place that header
may be resolved, too.

	Arnd
