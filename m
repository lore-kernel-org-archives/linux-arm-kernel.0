From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Dec 2015 08:21:00 +0100
Subject: [PATCH] ARM: avoid ARCH_MMAP_RND_BITS for NOMMU
In-Reply-To: <2874133.c4GDUf0t6t@wuerfel>
References: <2874133.c4GDUf0t6t@wuerfel>
Message-ID: <20151207072100.GQ5072@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 03:04:03PM +0100, Arnd Bergmann wrote:
> ARM kernels with MMU disabled fail to build because of CONFIG_ARCH_MMAP_RND_BITS:
> 
> kernel/built-in.o:(.data+0x754): undefined reference to `mmap_rnd_bits'
> kernel/built-in.o:(.data+0x76c): undefined reference to `mmap_rnd_bits_min'
> kernel/built-in.o:(.data+0x770): undefined reference to `mmap_rnd_bits_max'
> 
> This changes the newly added line to only select this allow for
> MMU-enabled kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 14570b3fd31a ("arm: mm: support ARCH_MMAP_RND_BITS")
> ---
> Found on yesterday's linux-next with ARM randconfig. The commit that
> introduced this is currently in Andrew's tree.
> 
> If you don't already have a fix, please either apply this patch on top,
> or fold it into the original patch.
hmm, our autobuilder still fails on this one because there has been no
next release since some time. I hope the best for tomorrow's build :-)

Anyhow, it fixes the build for efm32_defconfig, so

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
