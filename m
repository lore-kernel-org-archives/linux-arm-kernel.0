From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 11 Apr 2014 18:09:46 +0000 (UTC)
Subject: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss
 hwmod
In-Reply-To: <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com>
References: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com>
 <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Apr 2014, Paul Walmsley wrote:

> On Wed, 9 Apr 2014, Lokesh Vutla wrote:
> 
> > During boot, when hwmod tries to cut clocks for debugss it always
> > gets stuck in transition state and throws the following warning:
> > 
> > [    0.139581] omap_hwmod: debugss: _wait_target_disable failed
> > 
> > As per the information provided by folks, clocks to debugss cannot be cut.
> > So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Thanks, queued for v3.15-rc.

Hmmm.  On second thought, this doesn't look like the right fix.  Could 
you please comment on the issues raised here:

https://patchwork.kernel.org/patch/2212111/

Looks to me like there should be at least one device driver, either for 
the entire DEBUGSS, or for the individual IP blocks inside the DEBUGSS.

Dropping this patch for now.


- Paul
