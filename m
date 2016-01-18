From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jan 2016 09:59:19 +0000
Subject: [PATCH] ARM: debug-ll: fix BCM63xx entry for multiplatform
In-Reply-To: <5641204.G6RtGs3Kji@wuerfel>
References: <5641204.G6RtGs3Kji@wuerfel>
Message-ID: <20160118095919.GE19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 10:51:00AM +0100, Arnd Bergmann wrote:
> During my randconfig build testing, I found that a kernel with
> DEBUG_AT91_UART and ARCH_BCM_63XX fails to build:
> 
> arch/arm/include/debug/at91.S:18:0: error: "CONFIG_DEBUG_UART_VIRT" redefined [-Werror]

Why do we have files defining CONFIG_* symbols?  This is the real error
here - no source file should be defining this.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
