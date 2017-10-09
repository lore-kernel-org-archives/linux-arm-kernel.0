From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Oct 2017 16:05:23 +0100
Subject: [PATCH] kbuild: fix dependency of dtbs targets
In-Reply-To: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
References: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20171009150523.GT20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 04, 2017 at 01:27:20PM +0900, Masahiro Yamada wrote:
> The target "dtbs" should depend on "scripts" because it needs to
> build dtc.  The "prepare" target is unneeded here.

Looks fine for ARM, as the only thing the dtbs should depend on is
the kernel configuration (to decide which to build) and DT tooling.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
