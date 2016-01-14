From: kvalo@codeaurora.org (Kalle Valo)
Date: Thu, 14 Jan 2016 08:46:29 +0200
Subject: [PATCH] ssb: host_soc depends on sprom
In-Reply-To: <8128014.DbbgBtKY3z@wuerfel> (Arnd Bergmann's message of "Wed, 13
 Jan 2016 23:51:43 +0100")
References: <8128014.DbbgBtKY3z@wuerfel>
Message-ID: <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

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
> ---
> I'm not sure who the right person is to pick up the fix. The patch that
> introduced the problem was merged by Kalle through the iwlwifi tree.

I can take it. For historical reasons ssb patches go through my
wireless-drivers trees.

-- 
Kalle Valo
