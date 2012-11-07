From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Nov 2012 13:41:44 +0900
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <1351089457-8205-3-git-send-email-t.figa@samsung.com>
 <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
Message-ID: <0c5301cdbca2$30320240$909606c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Wed, Oct 24, 2012 at 4:37 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> 
> > This patch modifies the Samsung GPIO driver to check for pinctrl driver
> > presence earlier and use generic matching instead of a single compatible
> > value.
> >
> > This allows us to fix warning about unrecognized SoC in case of
> > Exynos4x12, which is not supported by this driver.
> >
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tell me if there is something you want merged through
> the GPIO or pinctrl tree. I have this Samsung branch on the
> pinctrl tree...
> 
Hi Linus, 

A commit 1b6056d6 ("pinctrl: samsung: Include bank-specific eint offset in
bank struct") which is in your pinctrl tree (samsung branch) changed
macro(EXYNOS_PIN_BANK_EINTG) to add offset. Eventually, this series(due to
3rd patch, pinctrl: samsung: Add support for Exynos4x12) breaks compilation
without the commit. So if you don't have a plan to rebase samsung branch of
your pinctrl tree, I'd like to merge it in my tree. Is it ok to you?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
