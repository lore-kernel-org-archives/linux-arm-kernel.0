From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 18:28:47 +0200
Subject: [PATCH 2/4] clk: exynos-audss: allow input clocks to be specified
 in device tree
In-Reply-To: <1373458313-18970-3-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
 <1373458313-18970-3-git-send-email-padma.v@samsung.com>
Message-ID: <1610421.OFFn8rqlxt@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi, Andrew,

On Wednesday 10 of July 2013 17:41:51 Padmavathi Venna wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> This allows the input clocks to the Exynos AudioSS block to be specified
> via device-tree bindings.  Default names will be used when an input clock
> is not given.  This will be useful when adding support for the
> Exynos5420 where the audio bus clock is called "sclk_maudio0" instead of
> "sclk_audio0".
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-on: https://gerrit.chromium.org/gerrit/57833
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |   31
> ++++++++++++++++++- drivers/clk/samsung/clk-exynos-audss.c             |
>   28 +++++++++++++++-- 2 files changed, 53 insertions(+), 6 deletions(-)

Well, this is basically how it should be done, but in current state of 
clock core I can see a problem: can we really rely on the order of clock 
initialization? I mean, we can't defer initialization of particular clock 
controller until all external clocks it needs are available, because there 
is no probing involved here.

Best regards,
Tomasz
