From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Aug 2017 21:47:52 +0200
Subject: [PATCH] ARM: ux500: don't select CPUFREQ_DT
In-Reply-To: <20170823132733.619811-1-arnd@arndb.de>
References: <20170823132733.619811-1-arnd@arndb.de>
Message-ID: <CACRpkdb9bOuVaLUA4XVd89a58Y6UWnifQXurOHVWYfOBDHQ02Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 3:27 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The new 'select CPUFREQ_DT' statement causes a warning in some
> configurations:
>
> warning: (ARCH_U8500) selects CPUFREQ_DT which has unmet direct dependencies (CPU_FREQ && HAVE_CLK && OF && (!CPU_THERMAL || THERMAL))
>
> No other platform does this, so I think for consistency it's
> best if we remove it again from ux500 and instead add the driver
> to the defconfig.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OK then. I should update the defconfig anyway.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Rafael, can you stick this on top of the other patches on
your cpufreq branch?

Yours,
Linus Walleij
