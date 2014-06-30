From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 15:49:34 +0200
Subject: [PATCH] clk: samsung: Register clk provider only after registering
 its all clocks
In-Reply-To: <1403106412-24526-1-git-send-email-s.nawrocki@samsung.com>
References: <1403106412-24526-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <53B16AEE.30003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.06.2014 17:46, Sylwester Nawrocki wrote:
> Ensure the clock provider is not registered until after all its related
> clocks were created and are ready to use. Currently there are races
> possible and any (of_)clk_get() call right after a clock provider's
> clk_init_cb callback call may fail.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> 
> NOTE: Tested only on Exynos4412.
> 
>  drivers/clk/samsung/clk-exynos3250.c |    2 ++
>  drivers/clk/samsung/clk-exynos4.c    |    2 ++
>  drivers/clk/samsung/clk-exynos5250.c |    2 ++
>  drivers/clk/samsung/clk-exynos5260.c |    2 ++
>  drivers/clk/samsung/clk-exynos5410.c |    2 ++
>  drivers/clk/samsung/clk-exynos5420.c |    2 ++
>  drivers/clk/samsung/clk-exynos5440.c |    2 ++
>  drivers/clk/samsung/clk-s3c2410.c    |    2 ++
>  drivers/clk/samsung/clk-s3c2412.c    |    2 ++
>  drivers/clk/samsung/clk-s3c2443.c    |    2 ++
>  drivers/clk/samsung/clk-s3c64xx.c    |    2 ++
>  drivers/clk/samsung/clk.c            |   19 ++++++++++---------
>  drivers/clk/samsung/clk.h            |    2 ++
>  13 files changed, 34 insertions(+), 9 deletions(-)

Applied for 3.17.

Best regards,
Tomasz
