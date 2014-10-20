From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Oct 2014 15:39:44 +0200
Subject: [PATCH] arm: fix flush_pfn_alias
In-Reply-To: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
References: <1413809642-12931-1-git-send-email-js07.lee@gmail.com>
Message-ID: <2144086.KBLsLT82pe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 October 2014 21:54:02 Jungseung Lee wrote:
> L1_CACHE_BYTES could be larger than real L1 cache line size.
> In that case, flush_pfn_alias function would omit to flush last bytes
> as much as L1_CACHE_BYTES - real cache line size.

Can you list an example on what CPU this would happen in the
patch description? Isn't the L1 cache line size always 32 bytes on ARM?

> So fix end address to "to + PAGE_SIZE - 1". The bottom bits of the address
> is LINELEN. that is ignored by mcrr.
> 
> Signed-off-by: Jungseung Lee <js07.lee@gmail.com>

Is this needed in stable backports?

	Arnd
