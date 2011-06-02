From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 2 Jun 2011 18:31:52 +0200
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110602163152.GH32751@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:03 Wed 01 Jun     , Marc Zyngier wrote:
> Currently, the boot CPU has its local timer enabled long after
> the delay loop has been calibrated. This makes it impossible to
> boot a system that only uses local timers, like the A15.
> 
> Use late_time_init hook to initialize the boot CPU local timer.
> Since shmobile is already using this hook, add an ARM specific
> arm_late_time_init hook that platforms can use instead.
> 
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
I propose to switch to early platform devce and earlytimer

this will avoid the arm_late_time_init hook

and will make it cross arch

Best Regards,
J.
