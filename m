From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 14:09:46 +0200
Subject: [PATCH 2/2] pinctrl: samsung: Fix link error with
 CONFIG_PINCTRL_EXYNOS disabled
In-Reply-To: <CACRpkdbJj9Newk+sCTvJzxA4V2cmJ3hzuQELv7t1wFMhd_Y8+Q@mail.gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1398545.9FqHoC0WZW@flatron>
 <CACRpkdbJj9Newk+sCTvJzxA4V2cmJ3hzuQELv7t1wFMhd_Y8+Q@mail.gmail.com>
Message-ID: <6940961.67Lk2axxPL@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tuesday 23 of April 2013 14:03:12 Linus Walleij wrote:
> On Wed, Apr 17, 2013 at 12:24 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Commit f67faf487 added driver data for Exynos5250, which is available
> > only if CONFIG_PINCTRL_EXYNOS is enabled. However probably due to merge
> > error, the reference to this driver data structure was located outside
> > of relevant ifdef and compiled unconditionally, leading to link error
> > with CONFIG_PINCTRL_EXYNOS.
> > 
> > This patch fixes mentioned link error by moving driver data entry under
> > ifdef CONFIG_PINCTRL_EXYNOS.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This does not apply to my "devel" branch in the pinctrl tree.
> 
> Could you rebase it on that branch?
> 
> Or is the error not even in my tree?

This one got sent incorrectly due to my mistake. Please try the correct 
version:

[PATCH RESEND 2/2] pinctrl: samsung: Fix link error with CONFIG_PINCTRL_EXYNOS 
disabled

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework
