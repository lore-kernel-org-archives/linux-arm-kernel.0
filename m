From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Apr 2013 14:03:12 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Fix link error with
 CONFIG_PINCTRL_EXYNOS disabled
In-Reply-To: <1398545.9FqHoC0WZW@flatron>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <20130416163331.GP26958@opensource.wolfsonmicro.com>
 <30362001.FF4K7WsZvh@flatron> <1398545.9FqHoC0WZW@flatron>
Message-ID: <CACRpkdbJj9Newk+sCTvJzxA4V2cmJ3hzuQELv7t1wFMhd_Y8+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 12:24 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Commit f67faf487 added driver data for Exynos5250, which is available
> only if CONFIG_PINCTRL_EXYNOS is enabled. However probably due to merge
> error, the reference to this driver data structure was located outside
> of relevant ifdef and compiled unconditionally, leading to link error
> with CONFIG_PINCTRL_EXYNOS.
>
> This patch fixes mentioned link error by moving driver data entry under
> ifdef CONFIG_PINCTRL_EXYNOS.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

This does not apply to my "devel" branch in the pinctrl tree.

Could you rebase it on that branch?

Or is the error not even in my tree?

Yours,
Linus Walleij
