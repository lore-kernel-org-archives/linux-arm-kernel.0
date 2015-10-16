From: mturquette@baylibre.com (Michael Turquette)
Date: Fri, 16 Oct 2015 05:49:35 -0700
Subject: [PATCH v2 1/2] clk: samsung: exynos5250: Add DISP1 clocks
In-Reply-To: <56203AD3.2050905@samsung.com>
References: <1444905084-22540-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444905084-22540-2-git-send-email-tomeu.vizoso@collabora.com>
 <56203AD3.2050905@samsung.com>
Message-ID: <20151016124935.20687.4394@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Krzysztof Kozlowski (2015-10-15 16:46:27)
> On 15.10.2015 19:31, Tomeu Vizoso wrote:
> > When the DISP1 power domain is powered off, there's two clocks that need
> > to be temporarily reparented to OSC, and back to their original parents
> > when the domain is powered on again.
> > 
> > We expose these two clocks in the DT bindings so that the DT node of the
> > power domain can reference them.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > Changes in v2:
> > - Reuse mout_aclk200_p
> > - Rename div_aclk300 as div_aclk300_disp
> > 
> >  drivers/clk/samsung/clk-exynos5250.c   | 14 +++++++++++++-
> >  include/dt-bindings/clock/exynos5250.h |  4 +++-
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied to clk-next.

Regards,
Mike

> 
> Best regards,
> Krzysztof
> 
> 
