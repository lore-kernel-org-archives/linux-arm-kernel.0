From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Jul 2016 23:26:35 -0700
Subject: [PATCH 0/4] ARM: OMAP2+: Fix AM335x RTC External Abort
In-Reply-To: <5791DC3A.6070808@ti.com>
References: <20160712175034.743-1-d-gerlach@ti.com> <5791DC3A.6070808@ti.com>
Message-ID: <20160723062635.GB28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160722 01:41]:
> On 12/07/16 20:50, Dave Gerlach wrote:
> > Hi,
> > With next-20160711 there is an external abort during boot on am335x
> > platforms from the RTC which is caused by commit 183e2077d007 ("ARM:
> > AM33xx: fix module_wait_ready without clkctrl register"), log is here [1].
> > The RTC hwmod is unique in that it has a clkctrl_offs of 0 which is
> > invalid normally, all other hwmods have non-zero offsets. Because of this,
> > we need to flag the hwmod so 0 actually gets used for the offset
> > instead of the just returning 0 and doing nothing.
> > 
> > This series adds a HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag and moves the check
> > for validity of the clkctrl_offs value to the omap_hwmod code so that we are
> > able to check both the flag and clkctrl_offs values. This code is shared by
> > all OMAP4+ platforms but shoudl have no affect for anything but RTC on
> > am335x but still boot tested on the following platforms:
> 
> Series looks good to me, so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Applying these into omap-for-v4,8/soc.

Regards,

Tony
