From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 07:49:37 +0200
Subject: [PATCH] clocksource: sun4i: Clear interrupts after stopping
 timer in probe function
In-Reply-To: <1469502119-2344-1-git-send-email-wens@csie.org>
References: <1469502119-2344-1-git-send-email-wens@csie.org>
Message-ID: <20160726054937.GS7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 11:01:59AM +0800, Chen-Yu Tsai wrote:
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
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Awesome, thanks!

You should put stable in Cc though for this kind of patches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/2725019d/attachment.sig>
