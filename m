From: neidhard.kim@lge.com (Jongsung Kim)
Date: Tue, 13 Oct 2015 11:06:44 +0900
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <5778996.I0Vmityi0g@wuerfel>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
 <20151007090121.GC21513@n2100.arm.linux.org.uk> <561B457F.5090104@lge.com>
 <5778996.I0Vmityi0g@wuerfel>
Message-ID: <561C6734.7010509@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 06:27 PM, Arnd Bergmann wrote:
> How about changing the zcomp code to pass the page pointer instead of the kernel space pointer? That would avoid having to do the kmap_atomic, which can itself be expensive on 32-bit machines and should not be needed here if you have a HW DMA engine doing the compression. Arnd 

Mainline zram uses lzo / lz4 library functions as backend. Using kmap_atomic and passing address look reasonable.
