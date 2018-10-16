From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 Oct 2018 15:11:52 +0200
Subject: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
In-Reply-To: <20181015123112.9379-4-m.szyprowski@samsung.com>
References: <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
 <20181015123112.9379-1-m.szyprowski@samsung.com>
 <20181015123112.9379-4-m.szyprowski@samsung.com>
Message-ID: <CAJKOXPdPk-ATQd-3jzWariPek_WjG3TeLv-LJfzGWA9H7rY96Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Oct 2018 at 14:31, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks. This patch adds a mode of cooperation
> with arch_timer driver, so kernel can use CP15 based timer interface via
> arch_timer driver, which is mandatory on ARM64. In such mode driver only
> configures MCT registers and starts the timer but don't register any
> clocksource or events in the system. Those are left to be handled by
> arch_timer driver.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 17 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
