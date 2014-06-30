From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 15:48:57 +0200
Subject: [PATCH v3] clk: exynos5420: Remove aclk66_peric from the clock
 tree description
In-Reply-To: <1402000514-30752-1-git-send-email-dianders@chromium.org>
References: <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <1402000514-30752-1-git-send-email-dianders@chromium.org>
Message-ID: <53B16AC9.7090509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.06.2014 22:35, Doug Anderson wrote:
> The "aclk66_peric" clock is a gate clock with a whole bunch of gates
> underneath it.  This big gate isn't very useful to include in our
> clock tree.  If any of the children need to be turned on then the big
> gate will need to be on anyway.  ...and there are plenty of other "big
> gates" that aren't described in our clock tree, some of which shut off
> collections of clocks that have no relationship in the hierarchy so
> are hard to model.
> 
> "aclk66_peric" is causing earlyprintk problems since it gets disabled
> as part of the boot process, so let's just remove it.
> 
> Strangely (and for no good reason) this clock is exported as part of
> the common clock bindings.  Remove it since there are no in-kernel
> device trees using it and no reason anyone out of tree should refer to
> it either.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v3:
> - Now just remove aclk66_peric from the tree as suggested by Tomasz.
> 
> Changes in v2:
> - Use GATE_A and clk_get().  Save the clock for putting later.
> - Return 0 from exynos5420_clk_late_init().
> 
>  drivers/clk/samsung/clk-exynos5420.c   | 85 ++++++++++++++++++++++------------
>  include/dt-bindings/clock/exynos5420.h |  1 -
>  2 files changed, 55 insertions(+), 31 deletions(-)

Applied as a fix for 3.16.

Best regards,
Tomasz
