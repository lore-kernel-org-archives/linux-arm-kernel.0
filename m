From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 22 Jun 2017 10:25:49 +0200
Subject: [PATCH v3.1 1/3] drm/rockchip: dw_hdmi: add RK3399 HDMI support
In-Reply-To: <594B79A4.1000509@rock-chips.com>
References: <1496992236-10634-1-git-send-email-mark.yao@rock-chips.com>
 <1751555.73cFbViMXZ@phil> <594B79A4.1000509@rock-chips.com>
Message-ID: <2895576.2l0uxY0YQ7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 22. Juni 2017, 16:02:44 CEST schrieb Mark yao:
> On 2017?06?22? 15:31, Heiko Stuebner wrote:
> >> +
> >> >+/**
> >> >+ * struct rockchip_hdmi_chip_data - splite the grf setting of kind of chips
> >> >+ * @lcdsel_grf_reg: grf register offset of lcdc select
> >> >+ * @lcdsel_big: reg value of selecting vop big for HDMI
> >> >+ * @lcdsel_lit: reg value of selecting vop little for HDMI
> >> >+ */
> >> >+struct rockchip_hdmi_chip_data {
> >> >+	u32	lcdsel_grf_reg;
> > How do you plan on handling the rk3368 (with only one VOP and thus
> > no selection happening)? I'd just make the above an int, so we could
> > set it to -1 for that case. (value 0 is after all a valid reg).
> 
> It's a problem handling on rk3368, using -1 to judge means that we need
> initial the lcdsel_grf_reg to -1 on rk3368 platform, we need always add a platform
> data to handle it, seems not good enough.
> 
> Since the hdmi chip data only use for vop selection, maybe we can judge with
> checking hdmi->chip_data == NULL for the case.

yeah, that could work as well ... as long as the grf-vop-select is the only chip-data
