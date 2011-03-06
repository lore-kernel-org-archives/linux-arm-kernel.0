From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Mar 2011 16:36:56 +0000
Subject: [PATCH] [ARM] tlb: fix build error with CONFIG_SWAP=n
In-Reply-To: <1299426386-28746-1-git-send-email-dbaryshkov@gmail.com>
References: <1299426386-28746-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110306163656.GH27468@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 06, 2011 at 06:46:26PM +0300, Dmitry Eremin-Solenikov wrote:
> Fix this build error with CONFIG_SWAP=n:
> 
> In file included from arch/arm/mm/init.c:28:
> arch/arm/include/asm/tlb.h: In function ?tlb_flush_mmu?:
> arch/arm/include/asm/tlb.h:104: error: implicit declaration of function ?release_pages?
> arch/arm/include/asm/tlb.h: In function ?tlb_remove_page?:
> arch/arm/include/asm/tlb.h:168: error: implicit declaration of function ?page_cache_release?

Already caught:

http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/fixes

11 days    Uwe Kleine...   ARM: 6757/1: fix tlb.h induced linux/swap.h
ago                        build failure

I've had about four of these patches over the last two weeks or so,
it would be a good idea to check the git tree before sending another
version of this.
