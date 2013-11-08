From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 08 Nov 2013 10:00:02 +0100
Subject: [patch 1/1] ARM: kirkwood: stop printk TCLK value at boot for
 DT boards
In-Reply-To: <20131105180931.674625171@rtp-net.org>
References: <20131105180931.674625171@rtp-net.org>
Message-ID: <527CA812.9050003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2013 07:09 PM, Arnaud Patard (Rtp) wrote:
> Commit 2326f04321a9 (ARM: kirkwood: convert to DT irqchip and clocksource)
> dropped the call to kirkwood_timer_init() when booting with DT.
> This results in kirkwood_tclk not being set and the boot message is now:
>
> Kirkwood: MV88F6281-A0, TCLK=0
>
> This patch modifies the message for printing only the kirkwood id,
> as it allows to detect if we're running A0/A1/... variants with a simple
> dmesg.

Arnaud,

for DT based booting we also have the "Machine" printed right above the
"Kirkwood" string. Don't you think, that we can remove the pr_info
completely?

Sebastian

> ---
>
> Index: linux-next/arch/arm/mach-kirkwood/board-dt.c
> ===================================================================
> --- linux-next.orig/arch/arm/mach-kirkwood/board-dt.c	2013-11-05 18:36:23.131191305 +0100
> +++ linux-next/arch/arm/mach-kirkwood/board-dt.c	2013-11-05 18:36:35.867190745 +0100
> @@ -140,7 +140,7 @@ eth_fixup_skip:
>
>   static void __init kirkwood_dt_init(void)
>   {
> -	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
> +	pr_info("Kirkwood: %s.\n", kirkwood_id());
>
>   	/*
>   	 * Disable propagation of mbus errors to the CPU local bus,
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
