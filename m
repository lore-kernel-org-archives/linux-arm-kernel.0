From: Barry.Song@csr.com (Barry Song)
Date: Mon, 22 Apr 2013 02:26:24 +0000
Subject: [PATCHv5 00/11] Remove ARM local timer API
In-Reply-To: <1366388385-30722-1-git-send-email-sboyd@codeaurora.org>
References: <1366388385-30722-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E9012A244417@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at codeaurora.org]
> Sent: Saturday, April 20, 2013 12:20 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org; linux-arm-msm at vger.kernel.org; Mark
> Rutland; Marc Zyngier; Kukjin Kim; Barry Song; Daniel Walker; Bryan Huntsman;
> Tony Lindgren; John Stultz; Thomas Gleixner; Thomas Abraham
> Subject: [PATCHv5 00/11] Remove ARM local timer API
> 
> In light of Mark Rutland's recent work on divorcing the ARM architected
> timers from the ARM local timer API and introducing a generic arch hook for
> broadcast it seems that we should remove the local timer API entirely.
> Doing so will reduce the architecture dependencies of our timer drivers,
> reduce code in ARM core, and simplify timer drivers because they no longer
> go through an architecture layer that is essentially a hotplug notifier.
> 
> Previous attempts have been made[1] unsuccessfully. I'm hoping this can
> be accepted now so that we can clean up the timer drivers that are
> used in both UP and SMP situations. Right now these drivers have to ignore
> the timer setup callback on the boot CPU to avoid registering clockevents
> twice. This is not very symmetric and causes convuluted code that does
> the same thing in two places.
> 
> Patches based on next-20130418
> 
> I'm still looking for Acks/Tested-by on EXYNOS and PRIMA2.

Stephen, I hope I can give a test soon. But I have some others in higher priority now.

> [1] http://article.gmane.org/gmane.linux.ports.arm.kernel/145705

-barry


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
