From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 24 Sep 2013 12:17:01 -0700 (PDT)
Subject: [PATCH V3 1/6] clk: exynos-audss: convert to platform device
In-Reply-To: <1380046016-5811-1-git-send-email-abrestic@chromium.org>
References: <1379982078-23381-1-git-send-email-abrestic@chromium.org>
 <1380046016-5811-1-git-send-email-abrestic@chromium.org>
Message-ID: <1706375.1GRhkzSkm0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tuesday 24 of September 2013 11:06:51 Andrew Bresticker wrote:
> The Exynos AudioSS clock controller will later be modified to allow
> input clocks to be specified via device-tree in order to support
> multiple Exynos SoCs.  This will introduce a dependency on the core
> SoC clock controller being initialized first so that the AudioSS driver
> can look up its input clocks, but the order in which clock providers
> are probed in of_clk_init() is not guaranteed.  Since deferred probing
> is not supported in of_clk_init() and the AudioSS block is not the core
> controller, we can initialize it later as a platform device.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> Changes since v2:
>  - add error handling to probe callback
>  - fixed ordering of of_clk_{add,del}_provider
>  - fixed nits from Tomasz and Sylwester
> Changes since v1:
>  - add clk_unregister() calls to remove callback
>  - fixed minor nits from Tomasz
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 109
> +++++++++++++++++++++++++++------ 1 file changed, 90 insertions(+), 19
> deletions(-)

For the whole series:

Acked-by: Tomasz Figa <t.figa@samsung.com>

Thanks for addressing all the comments.

Best regards,
Tomasz
