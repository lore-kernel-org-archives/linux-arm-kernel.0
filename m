From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 12:16:40 +0200
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <201207161554.04812.arnd@arndb.de>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-2-git-send-email-florian@openwrt.org>
 <201207161554.04812.arnd@arndb.de>
Message-ID: <20120717121640.589780ce@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 16 Jul 2012 15:54:04 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > +void mcs814x_restart(char mode, const char *cmd)
> > +{
> > +	__raw_writel(~(1 << 31), mcs814x_sysdbg_base);
> > +}
> 
> You should generally avoid using __raw_readl etc. and instead use
> readl/write or readl_relaxed/writel_relaxed.

I thought that readl/writel and readl_relaxed/writel_relaxed were used
for PCI-style access, for which these macros/functions do automatically
a conversion from the CPU-endianness to the PCI-endianness
(little-endian). Here of course, this the SoC is used little-endian, it
will just work because readl/writel will not do any endianness
conversion, but if we were on a big-endian machine?

My understanding until now was that __raw_readl/__raw_writel should be
used for accesses with native endianness, but apparently, it's more
subtle than this. Would you mind expanding a bit on this?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
