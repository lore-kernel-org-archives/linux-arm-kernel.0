From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 May 2014 15:48:17 +0200
Subject: [Ksummit-discuss] [TECH TOPIC] ARM legacy board DT conversion
 finalization
In-Reply-To: <4921873.t2F8plV493@wuerfel>
References: <20140511030009.GO12708@titan.lakedaemon.net>
 <4931877.zNfKfvcgox@wuerfel>
 <CAL_Jsq+kOu82okhJn0_ftwemE_m4nsTRawrF-fWAU2XTJ9xRcA@mail.gmail.com>
 <4921873.t2F8plV493@wuerfel>
Message-ID: <CACRpkdZ6oAO0sx-OwA-31FCPVWYeGH7zxmiog7OooMw_2_jzFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Ah, right. I see these two includes from mach-versatile to plat/*.h headers:
>
> arch/arm/mach-versatile/core.c:#include <plat/clcd.h>

I have a patch for this one.

> arch/arm/mach-versatile/core.c:#include <plat/sched_clock.h>

In the Integrator I solved this by inlining that code into the
machine. After the introduction of sched_clock_register()
this becomes very few lines of code really.

Yours,
Linus Walleij
