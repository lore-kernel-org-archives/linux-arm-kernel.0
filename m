From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 3 Nov 2016 21:12:46 +0200
Subject: [PATCH v3 1/5] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <1478155149-28527-2-git-send-email-cw00.choi@samsung.com>
References: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
 <1478155149-28527-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161103191246.GA12945@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 03:39:05PM +0900, Chanwoo Choi wrote:
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
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-gpio at vger.kernel.org
> Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../bindings/pinctrl/samsung-pinctrl.txt           | 19 ++++++++++
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 39 +++++++++------------
>  drivers/pinctrl/samsung/pinctrl-exynos.h           | 11 ++++++
>  drivers/pinctrl/samsung/pinctrl-samsung.c          | 40 ++++++++++++++--------
>  drivers/pinctrl/samsung/pinctrl-samsung.h          | 10 ++++--
>  5 files changed, 80 insertions(+), 39 deletions(-)
> 

Hi,

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
