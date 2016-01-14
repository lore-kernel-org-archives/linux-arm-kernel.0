From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 14 Jan 2016 09:45:44 +0100
Subject: [PATCH] ssb: host_soc depends on sprom
In-Reply-To: <8128014.DbbgBtKY3z@wuerfel>
References: <8128014.DbbgBtKY3z@wuerfel>
Message-ID: <CACna6rwAUh+LTBAepMTy1ZT7QhRYFPFmP5wPxyyQVb29gFwQYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2016 at 23:51, Arnd Bergmann <arnd@arndb.de> wrote:
> Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
> from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
> a build failure unless at least one of the other drivers that selects
> it is enabled:
>
> drivers/built-in.o: In function `ssb_host_soc_get_invariants':
> (.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'
>
> This adds the same select statement that is used elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")

I missed this dependency, thanks, patch looks OK.
