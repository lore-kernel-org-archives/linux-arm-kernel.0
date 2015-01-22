From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 22 Jan 2015 09:06:47 +0100
Subject: [PATCH] ARM: decompressor: remove unused cache flush code
In-Reply-To: <1421904178-30882-1-git-send-email-yamada.m@jp.panasonic.com>
References: <1421904178-30882-1-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <20150122080647.GX22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jan 22, 2015 at 02:22:58PM +0900, Masahiro Yamada wrote:
> As ARM ARM says, the bit 19-16 of ID_MMFR1 is always 0b0000 because
> ARMv7 requires a hierarchical cache implementation.
> The line "mcr    p15, 0, r10, c7, c14, 0" is not reachable.
> 
> Moreover, the v7_flush_dcache_all in arch/arm/mm/cache-v7.S does not
> check the ID_MMFR1.
> 
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
I stumbled about this some time ago, too. The thing is however that the
__armv7_mmu_cache functions are selected if
CPUID & 0x000f0000 == 0x000f0000, and that is (AFAIK at present only
theoretically) not implying that we have an ARMv7 machine. Only that it
uses the "CPUID Identification Scheme" which is required on ARMv7.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
