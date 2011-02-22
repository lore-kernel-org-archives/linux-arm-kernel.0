From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Feb 2011 13:57:10 -0800
Subject: [PATCH] ARM: fix build failure
In-Reply-To: <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110222201842.GB31275@n2100.arm.linux.org.uk>
	<1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110222215710.GT15225@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [110222 12:25]:
> Commit
> 
> 	06824ba (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs)
> 
> introduced a build failure for builds with CONFIG_SWAP=n:
> 
> 	In file included from arch/arm/mm/init.c:27:
> 	arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
> 	arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
> 	arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
> 	arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'
> 
> Fix that by #including <linux/pagemap.h> in <asm/pgalloc.h> as it's done
> by x86.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Tony Lindgren <tony@atomide.com>
