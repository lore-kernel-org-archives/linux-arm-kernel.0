From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 29 Jul 2013 08:50:16 -0700
Subject: [PATCH v6 4/5] clk: add CLK_SET_RATE_NO_REPARENT flag
In-Reply-To: <1375097102-28892-5-git-send-email-james.hogan@imgtec.com>
References: <1375097102-28892-1-git-send-email-james.hogan@imgtec.com>
 <1375097102-28892-5-git-send-email-james.hogan@imgtec.com>
Message-ID: <36053e73-faf4-47c6-9ff5-3e451361ef75@CH1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 12:25:01PM +0100, James Hogan wrote:
> Add a CLK_SET_RATE_NO_REPARENT clock flag, which will prevent muxes
> being reparented during clk_set_rate.
> 
> To avoid breaking existing platforms, all callers of clk_register_mux()
> are adjusted to pass the new flag. Platform maintainers are encouraged
> to remove the flag if they wish to allow mux reparenting on set_rate.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Chao Xie <xiechao.mail@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Emilio L?pez" <emilio@elopez.com.ar>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Chew <achew@nvidia.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: spear-devel at list.st.com
> Cc: linux-tegra at vger.kernel.org
> Tested-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> Acked-by: Stephen Warren <swarren@nvidia.com> [tegra]
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com> [sunxi]
ACK for Zynq.

I'll have to look at the details and do some testing to see whether we
can remove the flag later.

	S?ren
