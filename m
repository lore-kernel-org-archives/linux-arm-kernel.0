From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Nov 2017 22:38:10 +0000
Subject: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
In-Reply-To: <20171108223604.GG28231@n2100.armlinux.org.uk>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
 <20171108222755.GW28152@atomide.com>
 <20171108223604.GG28231@n2100.armlinux.org.uk>
Message-ID: <20171108223810.GH28231@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 10:36:04PM +0000, Russell King - ARM Linux wrote:
> We don't need a compiler warning there, we probably need better help
> text against DEBUG_LL and against EARLY_PRINTK.

Actually, this is already clearly stated against DEBUG_LL:

          Note that selecting this option will limit the kernel to a single
          UART definition, as specified below. Attempting to boot the kernel
          image on a different platform *will not work*, so this option should
          not be enabled for kernels that are intended to be portable.

and since EARLY_PRINTK depends on DEBUG_LL... I guess people don't
read help texts anymore.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
