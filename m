From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 26 Feb 2016 10:48:22 +0000 (UTC)
Subject: [RESEND] ssb: host_soc depends on sprom
In-Reply-To: <1456433869-3919332-1-git-send-email-arnd@arndb.de>
Message-ID: <20160226104822.921416089E@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


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

Thanks, applied to wireless-drivers.git.

Kalle Valo
