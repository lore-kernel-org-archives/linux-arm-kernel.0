From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Nov 2016 09:42:25 +0100
Subject: [PATCH v4 1/2] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <1478680811-24835-2-git-send-email-cw00.choi@samsung.com>
References: <1478680811-24835-1-git-send-email-cw00.choi@samsung.com>
 <1478680811-24835-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <CACRpkdZoxdE7=tyQuUQ2Bc-OaYVB1K2+Ez84tsBz-9AXwBt_6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 9:40 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:

> This patch supports the multiple IORESOURCE_MEM resources for one pin-bank.
> In the pre-existing Exynos series, the registers of the gpio bank are included
> in the one memory map. But, some gpio bank need to support the one more memory
> map (IORESOURCE_MEM) because the registers of gpio bank are separated into
> the different memory map.
>
> For example,
> The both ALIVE and IMEM domain have the different memory base address.
> The GFP[1-5] of exynos5433 are composed as following:
> - ALIVE domain : WEINT_* registers
> - IMEM domain  : CON/DAT/PUD/DRV/CONPDN/PUDPDN register
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied.

Yours,
Linus Walleij
