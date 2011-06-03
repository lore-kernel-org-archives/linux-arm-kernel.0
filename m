From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2011 09:57:35 +0100
Subject: [PATCH] ARM: local timers: Allow boot CPU to have its timer
	running early
In-Reply-To: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
References: <1306937006-26597-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110603085735.GH10532@n2100.arm.linux.org.uk>
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

Why do we need to initialize the per-cpu timer in late_time_init() ?
Is there a reason it doesn't work at time_init(), and if not can it
be fixed to work there?
