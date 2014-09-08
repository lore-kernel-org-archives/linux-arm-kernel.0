From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Sep 2014 16:39:46 +0100
Subject: [PATCH] ARM: avoid l2x0 build warning for CONFIG_OF=n
In-Reply-To: <2852268.nkG1OoBDfE@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
Message-ID: <20140908153946.GB12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 04:53:39PM +0200, Arnd Bergmann wrote:
> A few functions in the l2x0 code are now only used from code that
> is DT-only, so we get harmless gcc warnings about unused static
> symbols unless these are removed as well.
> 
> arch/arm/mm/cache-l2x0.c:167:13: warning: 'l2x0_cache_sync' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:184:13: warning: 'l2x0_flush_all' defined but not used [-Wunused-function]
> arch/arm/mm/cache-l2x0.c:194:13: warning: 'l2x0_disable' defined but not used [-Wunused-function]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cf9ea8f130e2 ("ARM: l2c: remove obsolete l2x0 ops for non-OF init")

I've already NAK'd patches like this.  This needs solving properly.

Never hide valid warnings like this.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
