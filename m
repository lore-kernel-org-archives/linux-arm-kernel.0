From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 22 Jul 2013 11:15:30 -0700
Subject: [PATCH 2/4] clk: exynos-audss: allow input clocks to be specified
 in device tree
In-Reply-To: <1610421.OFFn8rqlxt@amdc1227>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
 <1373458313-18970-3-git-send-email-padma.v@samsung.com>
 <1610421.OFFn8rqlxt@amdc1227>
Message-ID: <20130722181530.7598.73318@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-07-22 09:28:47)
> Hi Padmavathi, Andrew,
> 
> On Wednesday 10 of July 2013 17:41:51 Padmavathi Venna wrote:
> > From: Andrew Bresticker <abrestic@chromium.org>
> > 
> > This allows the input clocks to the Exynos AudioSS block to be specified
> > via device-tree bindings.  Default names will be used when an input clock
> > is not given.  This will be useful when adding support for the
> > Exynos5420 where the audio bus clock is called "sclk_maudio0" instead of
> > "sclk_audio0".
> > 
> > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > Reviewed-on: https://gerrit.chromium.org/gerrit/57833
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  .../devicetree/bindings/clock/clk-exynos-audss.txt |   31
> > ++++++++++++++++++- drivers/clk/samsung/clk-exynos-audss.c             |
> >   28 +++++++++++++++-- 2 files changed, 53 insertions(+), 6 deletions(-)
> 
> Well, this is basically how it should be done, but in current state of 
> clock core I can see a problem: can we really rely on the order of clock 
> initialization? I mean, we can't defer initialization of particular clock 
> controller until all external clocks it needs are available, because there 
> is no probing involved here.

The clock core allows registering clocks even if their parents are not
yet registered. I test this path with some dummy clocks every so often
to make sure the re-parenting operation are completed successfully after
the parents eventually are registered.

This feature was not used in practice until recently with the advent of
multiple clock controllers getting registered and DT description of
clocks / clock controllers that may be "out of order". If you find any
bugs please let me know ;-)

Regards,
Mike

> 
> Best regards,
> Tomasz
