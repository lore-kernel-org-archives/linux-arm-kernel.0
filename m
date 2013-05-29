From: dianders@chromium.org (Doug Anderson)
Date: Wed, 29 May 2013 10:58:02 -0700
Subject: [PATCH v2 1/5] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <1369834677-20312-2-git-send-email-vikas.sajjan@linaro.org>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-2-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=XAc0R4gHrogYE3gAp5ANWFfo2UT0LCkhn3eVV0b5ukxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas / Yadwinder,

On Wed, May 29, 2013 at 6:37 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>
> To factor out possible common code, this patch unifies the clk strutures used
> for PLL35xx & PLL36xx and usues clk->base instead of clk->con0.
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos4.c    |   10 ++++---
>  drivers/clk/samsung/clk-exynos5250.c |   14 ++++-----
>  drivers/clk/samsung/clk-pll.c        |   54 ++++++++++++++++++----------------
>  drivers/clk/samsung/clk-pll.h        |    4 +--
>  4 files changed, 44 insertions(+), 38 deletions(-)

I've run with this patch atop our CCF backport on 3.8 on on
exynos5250-snow.  It works and looks good to me.  We're planning to
put this patch into our tree at
<https://gerrit.chromium.org/gerrit/#/c/56740>.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
