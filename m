From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 22:13:12 -0500
Subject: [patch 1/1] ARM: kirkwood: stop printk TCLK value at boot for
 DT boards
In-Reply-To: <20131105180931.674625171@rtp-net.org>
References: <20131105180931.674625171@rtp-net.org>
Message-ID: <20131124031312.GT29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 07:09:14PM +0100, Arnaud Patard wrote:
> Commit 2326f04321a9 (ARM: kirkwood: convert to DT irqchip and clocksource)
> dropped the call to kirkwood_timer_init() when booting with DT.
> This results in kirkwood_tclk not being set and the boot message is now:
> 
> Kirkwood: MV88F6281-A0, TCLK=0
> 
> This patch modifies the message for printing only the kirkwood id,
> as it allows to detect if we're running A0/A1/... variants with a simple
> dmesg.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
> 
> Index: linux-next/arch/arm/mach-kirkwood/board-dt.c

Applied to mvebu/soc with Sebastian and Andrew's Acks.

thx,

Jason.
