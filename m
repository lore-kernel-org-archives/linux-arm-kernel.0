From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Mon, 15 Aug 2016 22:55:53 +0200
Subject: [PATCH v2] clocksource: sun4i: Clear interrupts after stopping
 timer in probe function
In-Reply-To: <1471237024-16655-1-git-send-email-wens@csie.org>
References: <1471237024-16655-1-git-send-email-wens@csie.org>
Message-ID: <20160815205552.72dv76g3jktucpta@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 12:57:04PM +0800, Chen-Yu Tsai wrote:
> The bootloader (U-boot) sometimes uses this timer for various delays.
> It uses it as a ongoing counter, and does comparisons on the current
> counter value. The timer counter is never stopped.
> 
> In some cases when the user interacts with the bootloader, or lets
> it idle for some time before loading Linux, the timer may expire,
> and an interrupt will be pending. This results in an unexpected
> interrupt when the timer interrupt is enabled by the kernel, at
> which point the event_handler isn't set yet. This results in a NULL
> pointer dereference exception, panic, and no way to reboot.

Thanks for tracking down this bug. It bit me too once. Now I won't
wonder if it was my fault. I do wonder if there are more interrupts
which need their pending status cleared in the probe function.

-- 
Rask Ingemann Lambertsen
