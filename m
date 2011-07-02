From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Sat, 02 Jul 2011 12:13:57 +0300
Subject: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
In-Reply-To: <1309552901-8944-18-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-18-git-send-email-b-cousson@ti.com>
Message-ID: <1309598037.1846.3.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Fri, 2011-07-01 at 22:41 +0200, Benoit Cousson wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Add missing DSS optional clocks to HWMOD data for OMAP4xxx.
> 
> Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> [b-cousson at ti.com: Remove a comment and update the subject]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

This patch adds "fck" opt-clocks for DSS. After your patch set
for_3.1/5_auto_fck_clkdev, in which you create "fck" automatically, I
see:

[    0.218231] omap_device: omapdss_dss: fck already exist
[    0.218261] omap_device: omapdss_dss: fck already exist
[    0.218261] omap_device: omapdss_dss: sys_clk already exist
[    0.218261] omap_device: omapdss_dss: tv_clk already exist
[    0.218322] omap_device: omapdss_dss: video_clk already exist
[    0.218627] omap_device: omapdss_dispc: fck already exist
[    0.219329] omap_device: omapdss_venc: fck already exist
[    0.219635] omap_device: omapdss_dsi1: fck already exist
[    0.219970] omap_device: omapdss_dsi2: fck already exist
[    0.220336] omap_device: omapdss_hdmi: fck already exist

So I think the "fck" clocks in this patch should be removed. I only
added them for compatibility, as I didn't have the automatic "fck"
creation patch in my tree.

Also, either you didn't email the patch set in
for_3.1/5_auto_fck_clkdev, or I'm just blind... 

 Tomi
