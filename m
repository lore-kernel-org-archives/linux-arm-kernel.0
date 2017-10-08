From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Oct 2017 01:31:38 +0200
Subject: [PATCH] ARM: ux500: Fix regression while init PM domains
In-Reply-To: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
References: <1507263625-16756-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CACRpkdau60y2foj06R7=BTAJ4sob+QNLOadCDajnznZtdohdYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 6:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The commit afece3ab9a36 ("PM / Domains: Add time accounting to various
> genpd states") causes a boot regression for ux500.
>
> The problem occurs when the ux500 machine code calls pm_genpd_init(), which
> since the above change triggers a call to ktime_get(). More precisely,
> because ux500 initializes PM domains in the init_IRQ() phase of the boot,
> timekeeping has not yet been initialized.
>
> Fix the problem by moving the initialization of the PM domains to after
> timekeeping has been initialized.
>
> Fixes: afece3ab9a36 ("PM / Domains: Add time accounting to various genpd..")
> Cc: Thara Gopinath <thara.gopinath@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

ARM SoC folks: please apply this directly for fixes!

Yours,
Linus Walleij
