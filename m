From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 16:20:48 -0700
Subject: [PATCH v3 2/2] clk: prevent orphan clocks from being used
In-Reply-To: <1429735986-18592-3-git-send-email-heiko@sntech.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <1429735986-18592-3-git-send-email-heiko@sntech.de>
Message-ID: <20150430232048.GB32407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22, Heiko Stuebner wrote:
> Orphan clocks or children of orphan clocks don't have rate information at
> all and can produce strange results if they're allowed to be used and the
> parent becomes available later on.
> 
> So using the newly introduced orphan status bit defer
> __of_clk_get_from_provider calls for orphan clocks.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: kernel at pengutronix.de
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Chao Xie <chao.xie@marvell.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Georgi Djakov <georgi.djakov@linaro.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
> Cc: emilio at elopez.com.ar
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Michal Simek <michal.simek@xilinx.com>

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
