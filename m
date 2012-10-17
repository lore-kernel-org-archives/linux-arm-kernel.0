From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 19:41:10 -0700
Subject: [PATCHv6 01/11] ARM: OMAP: clockdomain: Fix locking on
 _clkdm_clk_hwmod_enable / disable
In-Reply-To: <alpine.DEB.2.00.1210170224570.9767@utopia.booyaka.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
 <1348589142-11983-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1210170224570.9767@utopia.booyaka.com>
Message-ID: <20121017024109.GR15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121016 19:26]:
> On Tue, 25 Sep 2012, Tero Kristo wrote:
> 
> > Previously the code only acquired spinlock after increasing / decreasing
> > the usecount value, which is wrong. This leaves a small window where
> > a task switch may occur between the check of the usecount and the actual
> > wakeup / sleep of the domain. Fixed by moving the spinlock locking before
> > the usecount access. Left the usecount as atomic_t if someone wants an
> > easy access to the parameter through atomic_read.
> > 
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

OK I'll apply this into omap-for-v3.7-rc1/fixes-take4.

Regards,

Tony
