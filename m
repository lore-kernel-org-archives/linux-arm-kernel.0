From: dianders@chromium.org (Doug Anderson)
Date: Thu, 30 May 2013 09:25:29 -0700
Subject: [PATCH v2 3/5] clk: samsung: Add set_rate() clk_ops for PLL35xx
In-Reply-To: <1369834677-20312-4-git-send-email-vikas.sajjan@linaro.org>
References: <1369834677-20312-1-git-send-email-vikas.sajjan@linaro.org>
 <1369834677-20312-4-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=VnrVAR6Uiy9VXAhbPLQxzeuQXZ3m0WQ6YhJzehaUdBog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas / Yadwinder,

On Wed, May 29, 2013 at 6:37 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> From: Yadwinder Singh Brar <yadi.brar@samsung.com>
>
> This patch add set_rate() and round_rate() for PLL35xx
>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> ---
>  drivers/clk/samsung/clk-pll.c |  103 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
[ cut ]
> +#define PLL35XX_LOCK_STAT_MASK  (0x1)

optional: Mask is _slightly_ overkill here. Could just assume that
it's a 1-bit thing and do (1 << PLL35XX_LOCK_STAT_SHIFT).


All comments are optional, so feel free to add my Reviewed-by:

Reviewed-by: Doug Anderson <dianders@chromium.org>
