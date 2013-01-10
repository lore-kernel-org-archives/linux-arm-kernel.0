From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 21:20:55 +0800
Subject: [PATCH v2 2/2] ARM: imx: enable imx6q-cpufreq support
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
 <1357806863-6899-3-git-send-email-shawn.guo@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433ECDF7BF@DBDE01.ent.ti.com>
 <20130110110742.GI2265@S2101-09.ap.freescale.net>
 <B5906170F1614E41A8A28DE3B8D121433ECDFC9B@DBDE01.ent.ti.com>
Message-ID: <20130110132053.GA9139@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 01:02:30PM +0000, Bedia, Vaibhav wrote:
> In the current approach the OPP data is split across DT and kernel code. If you take the
> other approach all OPP entries can reside in DT and for someone just looking at that file
> there's no confusion about what the kernel could potentially support. Whether a particular
> an OPP should be supported is best decided at runtime.
> 
Listing the OPP that some Si rev can not support in DT is also
a confusion to people who is just looking at DTS.  To me, the approach
is not really doing anything better on this aspect.

> Also, IMHO letting platforms invoke opp_add() is open to abuse and platforms should be
> restricted to invoking opp_enable/disable to indicate what's possible on a particular Si rev. 
> 
I do not see anything wrong with platform adding the OPP it can support.
Isn't omap_init_opp_table() being called by platform code?  I do not see
omap-cpufreq driver is calling a platform hook to do that.

Sorry, I'm not really a fan of platform hook, and I have spent past
couple years to minimize the use of it when converting IMX family to
device tree.

Shawn
