From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Feb 2016 14:39:22 +0100
Subject: [PATCH] ARM: realview: hide unused 'pmu_device' object
In-Reply-To: <1456234567-3705502-1-git-send-email-arnd@arndb.de>
References: <1456234567-3705502-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYGbg1S9MCVdcy6z1qBF6zXMA=JJag=51mGre+n+-Ar0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 2:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The pmu_device is only accessed when CACHE_L2X0 is enabled,
> and we get a warning otherwise:
>
> mach-realview/realview_pbx.c:274:31: error: 'pmu_device' defined but not used [-Werror=unused-variable]
>
> This adds another #ifdef for it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Linus, I'm not sure how long you plan to keep the board file around,
> so just ignore the patch if this is getting deleted anyway, otherwise
> it would be nice if you could add the patch to your series.

I'll queue it in the bottom of my stack, it doesn't hurt.

I'm working on DTSes for the PBX as we speak.

Yours,
Linus Walleij
