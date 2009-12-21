From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Dec 2009 23:35:59 +0000
Subject: [PATCH] ARM: fix arch/arm/mm/copypage-v6.c build
In-Reply-To: <4B2DE16E.4050708@compulab.co.il>
References: <4B2DE16E.4050708@compulab.co.il>
Message-ID: <20091221233559.GC28541@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2009 at 10:33:50AM +0200, Mike Rapoport wrote:
> Commit 115b22474eb1905da2f606a057da3455833333d3 (ARM: 5794/1: Flush the
> D-cache during copy_user_highpage()) breaks build for ARM v7:
> 
>   CC      arch/arm/mm/copypage-v6.o
> arch/arm/mm/copypage-v6.c: In function'v6_copy_user_highpage_nonaliasing':
> arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> make[2]: *** [arch/arm/mm/copypage-v6.o] Error 1

This one's already been caught.
