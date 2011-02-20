From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Feb 2011 11:03:41 +0000
Subject: [PATCH 1/5] ARM: smp: Select local timers vs dummy timer
	support runtime
In-Reply-To: <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110220110341.GA15494@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 04:59:43PM +0530, Santosh Shilimkar wrote:
> -#ifndef CONFIG_LOCAL_TIMERS
>  static void broadcast_timer_set_mode(enum clock_event_mode mode,
>  	struct clock_event_device *evt)
>  {
>  }
>  
> -static void local_timer_setup(struct clock_event_device *evt)
> +static void dummy_timer_setup(struct clock_event_device *evt)

Please call this broadcast_timer_setup().
