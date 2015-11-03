From: john.stultz@linaro.org (John Stultz)
Date: Tue, 3 Nov 2015 07:18:36 -0800
Subject: [PATCH 20/22] clocksource/drivers/exynos_mct: Fix Kconfig and add
 COMPILE_TEST option
In-Reply-To: <9713489.TbNNoNQg5A@wuerfel>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <563806E7.6010105@samsung.com> <563872E2.10001@linaro.org>
 <9713489.TbNNoNQg5A@wuerfel>
Message-ID: <CALAqxLUHJVm_ipyJuMTKRJJ=h1UbA=94-GJL7pZrjaco6Rg8EQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 2:02 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I suspect this will come up again in the future. The problem is
> really that drivers/clocksource has different rules from almost
> everything else, by requiring the platform to 'select' the driver.
>
> The second version that Krzysztof posted is how we handle this in
> other driver subsystems, and I would generally prefer it to do this
> consistently for everything, but John Stultz has in the past argued
> strongly for using 'select' in all clocksource drivers. The reason
> is that for each platform we know in advance which driver we want,
> and there is never a need for the user to have to select the right
> one.

And just to clarify, I don't necessarily think "select" is the right
method, as creating an option that defaults to Y if the right
architecture/platform support is present is fine too.

I just don't want users to have to search deeply through menuconfig to
find a clocksource driver checkbox when they have already selected a
platform and provided enough information for us to know which
clocksource driver is needed.  So my argument its really all about
avoiding user-prompts in kconfig for clocksources.  It is conceptually
easier to do this w/ select, but you can also do it via default y and
proper dependencies.

thanks
-john
