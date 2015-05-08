From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 May 2015 17:50:37 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: PRM: Fix am437x module reset
In-Reply-To: <1430508422-64913-1-git-send-email-d-gerlach@ti.com>
References: <1430508422-64913-1-git-send-email-d-gerlach@ti.com>
Message-ID: <alpine.DEB.2.02.1505081749320.19833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave 

On Fri, 1 May 2015, Dave Gerlach wrote:

> When moving to using the OMAP4+ PRM driver on am437x, we switched
> to using all omap4 ops for module reset management. However, reset
> register layout on am437x is more similar to am335x than omap4 because
> of the the need for an st_shift for the *_RST bits in certain *_RSTST
> registers, like WKUP_PROC_LRST in the PRCM_RM_WKUP_RSTST. Without this
> we cannot bring the Wakeup M3 IP out of reset.
> 
> Because of this, we must use the am33xx prm ops for the hardreset
> functionality while continuing to use all other omap4 ops. To accomplish
> this we split out the common portion of omap44xx_prm_init and add an
> am437x_prm_init to register the prm_ll_data struct specific to am437x.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>

I'm assuming this has been superseded by Tero's patches.  If not, please 
let me know.


- Paul
