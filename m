From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 10:04:09 +0200
Subject: [PATCH v3] clocksource: sun4i: Clear interrupts after stopping
 timer in probe function
In-Reply-To: <20160825062659.17433-1-wens@csie.org>
References: <20160825062659.17433-1-wens@csie.org>
Message-ID: <20160825080409.GE7776@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:26:59PM +0800, Chen-Yu Tsai wrote:
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
> 
> Clear any pending interrupts after we stop the timer in the probe
> function to avoid this.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/c0fae385/attachment.sig>
