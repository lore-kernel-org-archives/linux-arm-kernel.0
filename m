From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Aug 2016 14:00:43 -0500
Subject: [PATCH 4/7] pinctrl: samsung: Add GPFx support of Exynos5433
In-Reply-To: <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <20160818190043.GA11359@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:27:20PM +0900, Chanwoo Choi wrote:
> From: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> This patch add the support of GPFx pin of Exynos5433 SoC. Exynos5433 has
> different memory map of GPFx from previous Exynos SoC. Exynos GPIO has
> following register to control gpio funciton. Usually, all registers of GPIO
> are included in same domain.
> - CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND
> 
> But, GPFx are included in two domain as following. So, this patch supports
> the GPFx pin which handle the on separate two domains.
> - ALIVE domain : CON / DAT / PUD / DRV / CONPDN / PUDPDN
> - IMEM domain  : EINT_CON/ EINT_FLTCON0, EINT_FLTCON1 / EINT_MASK / EINT_PEND
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/pinctrl/samsung-pinctrl.txt           |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/samsung/pinctrl-exynos.c           |  5 +++
>  drivers/pinctrl/samsung/pinctrl-exynos.h           | 11 ++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c          | 43 ++++++++++++++++++----
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |  5 +++
>  5 files changed, 57 insertions(+), 8 deletions(-)
