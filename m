From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Oct 2012 05:45:26 +0000 (UTC)
Subject: [PATCHv6 01/11] ARM: OMAP: clockdomain: Fix locking on
 _clkdm_clk_hwmod_enable / disable
In-Reply-To: <1348589142-11983-2-git-send-email-t-kristo@ti.com>
References: <1348589142-11983-1-git-send-email-t-kristo@ti.com>
 <1348589142-11983-2-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1210160545110.9767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Sep 2012, Tero Kristo wrote:

> Previously the code only acquired spinlock after increasing / decreasing
> the usecount value, which is wrong. This leaves a small window where
> a task switch may occur between the check of the usecount and the actual
> wakeup / sleep of the domain. Fixed by moving the spinlock locking before
> the usecount access. Left the usecount as atomic_t if someone wants an
> easy access to the parameter through atomic_read.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, queued for 3.7-rc fixes.


- Paul
