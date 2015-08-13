From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Aug 2015 16:37:07 +0100
Subject: [PATCH-next 1/4] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
In-Reply-To: <1439409416-32673-2-git-send-email-balbi@ti.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-2-git-send-email-balbi@ti.com>
Message-ID: <20150813153707.GF7576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 02:56:53PM -0500, Felipe Balbi wrote:
> This reverts commit 904464b91eca8c665acea033489225af02eeb75a.
> 
> The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
> smp_twd: make twd_local_timer_of_register() no-op for nosmp")
> doesn't exist anymore.
> 
> We can safely boot with nosmp and the warning won't show up.
> 
> The other side benefit of this patch is that TWD has a chance
> to probe on single-core A9 systems such as AM437x which sport
> TWD.

I don't remember all the details from Feb 2013 on why we made that
change.  If this is proven safe, then I guess it's okay.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
