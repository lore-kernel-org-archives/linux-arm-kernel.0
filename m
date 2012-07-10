From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Jul 2012 13:07:36 +0200 (CEST)
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710094249.GF10225@elf.ucw.cz>
References: <20120710094249.GF10225@elf.ucw.cz>
Message-ID: <alpine.LFD.2.02.1207101304160.32033@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Jul 2012, Pavel Machek wrote:
>  		timer0: timer at ffc08000 {
> -				compatible = "socfpga,sp-timer";
> +				compatible = "snps,dw-apb-timer-sp";

apb timer. That rings a bell. Does that have anything to do with

arch/x86/kernel/apb_timer.c ? That's from one of the intel mobile
chips and might be the very same IP block.

> -obj-y					:= common.o time.o
> +obj-y					:= common.o ../../../drivers/clocksource/dw_apb_timer_of.o

Urgh! Why can't we just compile it from drivers/clocksource/Makefile ?

Otherwise, yes please move the code instead of creating a copy.

Thanks,

	tglx
