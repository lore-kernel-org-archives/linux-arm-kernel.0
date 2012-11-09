From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Nov 2012 21:22:00 +0000 (UTC)
Subject: [PATCH 15/26] ARM: omap2: clock: Add 24xx data using common
 struct clk
In-Reply-To: <20121109210543.17381.15878@nucleus>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <1352337181-29427-16-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211081532210.20703@utopia.booyaka.com>
 <alpine.DEB.2.00.1211092030360.20703@utopia.booyaka.com>
 <20121109210543.17381.15878@nucleus>
Message-ID: <alpine.DEB.2.00.1211092112340.20703@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Nov 2012, Mike Turquette wrote:

> Quoting Paul Walmsley (2012-11-09 12:32:59)
> > Here's another update on this one to add the twl.fck clock alias, recently 
> > added by commit defa6be1c8216ed2d52d65db81a8a148e73be5f7 ("mfd: Fix 
> > compile for twl-core.c by removing cpu_is_omap usage").
> > 
> 
> I'll post a new series to the list with these fixes rolled in.  

Unless you've got other changes, no need to worry about it -  will deal 
with it here.

> Do you want me to squash the clkdm_clk_disable/usecount patch into 
> another patch in the series or keep it separate?  Separate might be good 
> since we're going to replace that solution with some force-disable thing 
> in the future.

Have moved that one up earlier in the patch stack and added the matching 
cleanup to the last patch.  Will repush the branch once it completes 
testing again.

Re the upstream CCF support for this, would suggest adding the CCF support 
for the new function pointer in this merge window (3.8) since it should 
be relatively straightforward.  Then during the 3.9 merge window, the 
OMAP code can be switched over to use it.


- Paul
