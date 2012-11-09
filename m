From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Nov 2012 19:06:28 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
In-Reply-To: <20121109011738.17381.88199@nucleus>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
 <1352417516-15213-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
 <20121109011738.17381.88199@nucleus>
Message-ID: <alpine.DEB.2.00.1211091900250.20703@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2012, Mike Turquette wrote:

> You're right.  In my rush I glossed over the clkdm decrement part.  In
> light of the suspend/resume issues I'm not sure this approach is really
> valid.  I think getting to the bottom of those issues will give the
> final word.

What do you think about something like this?  It's still under test and 
review here, but seems to avoid the warnings on 3530ES3 Beagle at least.

The usage of __clk_get_enable_count() in this code still seems like a hack 
to me.  It would be better for the CCF to call a different clk_hw_ops 
function pointer for the disable-unused-clocks case.  But if you agree, 
and plan to fix this, or have some other cleaner fix in mind for the near 
future, then something like this seems reasonable for the short term to 
me.  What do you think?


- Paul
