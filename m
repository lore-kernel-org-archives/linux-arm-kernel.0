From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 1 Feb 2016 14:57:36 +0100
Subject: [PATCH] PM / Domains: mark genpd_poweron as __maybe_unused
In-Reply-To: <3864075.BdhPDUQ9fB@wuerfel>
References: <3864075.BdhPDUQ9fB@wuerfel>
Message-ID: <CAPDyKFpHBgaQEz6kYvhV=2pLPLAtVxQjbnqL4CPv0vyvHZbHWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2016 at 11:38, Arnd Bergmann <arnd@arndb.de> wrote:
> The rework of the power domain code has made the genpd_poweron()
> function local to the file it's defined in, and the only remaining
> caller is conditionally compiled based on CONFIG_PM_GENERIC_DOMAINS_OF,
> so we get a warning when that is disabled:
>
> drivers/base/power/domain.c:234:12: error: 'genpd_poweron' defined but not used [-Werror=unused-function]
>
> This adds a __maybe_unused annotation to the function so gcc can
> figure out by itself that it should silently remove the definition
> in this case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ea823c7cbffa ("PM / Domains: Remove pm_genpd_poweron() API")

Arnd,

Thanks for fixing and reporting!

Looking a bit closer to the genpd code in this reagrds, made me
realize that I think there's a better approach to fix this.
Instead of going into the details for how, I decided to send a
separate patch. You are on cc.

"[PATCH] PM / Domains: Silence compiler warning for an unused function".

Kind regards
Uffe
