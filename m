From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Aug 2014 23:53:26 +0100
Subject: [PATCH] arch: Kconfig: Let all little endian architectures
 define CPU_LITTLE_ENDIAN explicitly
In-Reply-To: <53E93334.5000205@gmail.com>
References: <53E93334.5000205@gmail.com>
Message-ID: <20140811225326.GF30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 05:18:44AM +0800, Chen Gang wrote:
> x86, ia64, and arm(64) are little endian, and also another architectures
> may be little endian (mips, sh, powerpc, and m32r) which already marked
> CPU_LITTLE_ENDIAN explicitly.

This is incorrect.  ARM can be either endian.

arch/arm/mm/Kconfig:

config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        depends on ARCH_SUPPORTS_BIG_ENDIAN
        help
          Say Y if you plan on running a kernel in big-endian mode.
          Note that your board must be properly built and your board
          port must properly enable any big-endian related features
          of your chipset/board/processor.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
