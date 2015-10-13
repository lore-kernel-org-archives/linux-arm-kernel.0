From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 13:44:09 +0200
Subject: [PATCH] ARM:mm: fix kmap_atomic_to_page
In-Reply-To: <561C6734.7010509@lge.com>
References: <1444129773-12632-1-git-send-email-chanho.min@lge.com>
 <5778996.I0Vmityi0g@wuerfel> <561C6734.7010509@lge.com>
Message-ID: <5510159.Ge1KiGjbaB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 11:06:44 Jongsung Kim wrote:
> On 10/12/2015 06:27 PM, Arnd Bergmann wrote:
> > How about changing the zcomp code to pass the page pointer instead of the kernel space pointer? That would avoid having to do the kmap_atomic, which can itself be expensive on 32-bit machines and should not be needed here if you have a HW DMA engine doing the compression. Arnd 
> 
> Mainline zram uses lzo / lz4 library functions as backend. Using kmap_atomic and passing address look reasonable.

Yes, I know, but changing this to do the kmap_atomic in the backend
seems better here if you are adding another backend that doesn't
want or need the kmap_atomic.

	Arnd
