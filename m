From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 16:26:09 +0000 (UTC)
Subject: [PATCH 4/4] ARM: AM33XX: clock: SET_RATE_PARENT in lcd path
In-Reply-To: <24c9e4241b2988e66abd053508991d96cac964b7.1358871018.git.afzal@ti.com>
References: <cover.1358871018.git.afzal@ti.com>
 <24c9e4241b2988e66abd053508991d96cac964b7.1358871018.git.afzal@ti.com>
Message-ID: <alpine.DEB.2.00.1301311625290.32145@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jan 2013, Afzal Mohammed wrote:

> LCDC clock node is a one that does not have set rate capability. It
> just passes on the rate that is sent downstream by it's parent. While
> lcdc clock parent and it's grand parent - dpll_disp_m2_ck and
> dpll_disp_ck has the capability to configure rate.
> 
> And the default rates provided by LCDC clock's ancestors are not
> sufficient to obtain pixel clock for current LCDC use cases, hence
> currently display would not work on AM335x SoC's (with driver
> modifications in platfrom independent way).
> 
> Hence inform clock framework to propogate set rate for LCDC clock as
> well as it's parent - dpll_disp_m2_ck. With this change, set rate on
> LCDC clock would get propogated till dpll_disp_ck via dpll_disp_m2_ck,
> hence allowing the driver (same driver is used in DaVinci too) to set
> rates using LCDC clock without worrying about platform dependent clock
> details.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>

This one doesn't apply for me on v3.8-rc5 + your patches 2 and 3.  Could 
you please update it and re-send?


- Paul
