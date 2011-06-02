From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 2 Jun 2011 15:04:43 +0900
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110602060443.GD6087@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 03:03:26PM +0100, Marc Zyngier wrote:
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

Fine with me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
