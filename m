From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jan 2015 15:44:00 +0000
Subject: [PATCH] ARM: decompressor: remove unused cache flush code
In-Reply-To: <20150122080647.GX22880@pengutronix.de>
References: <1421904178-30882-1-git-send-email-yamada.m@jp.panasonic.com>
 <20150122080647.GX22880@pengutronix.de>
Message-ID: <20150122154400.GB26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 09:06:47AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Jan 22, 2015 at 02:22:58PM +0900, Masahiro Yamada wrote:
> > As ARM ARM says, the bit 19-16 of ID_MMFR1 is always 0b0000 because
> > ARMv7 requires a hierarchical cache implementation.
> > The line "mcr    p15, 0, r10, c7, c14, 0" is not reachable.
> > 
> > Moreover, the v7_flush_dcache_all in arch/arm/mm/cache-v7.S does not
> > check the ID_MMFR1.
> > 
> > Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
> I stumbled about this some time ago, too. The thing is however that the
> __armv7_mmu_cache functions are selected if
> CPUID & 0x000f0000 == 0x000f0000, and that is (AFAIK at present only
> theoretically) not implying that we have an ARMv7 machine. Only that it
> uses the "CPUID Identification Scheme" which is required on ARMv7.

Correct, and there are ARMv6 CPUs which satisfy the "CPUID identification
scheme" test - and are probably not heirarchial.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
