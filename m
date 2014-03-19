From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Mar 2014 20:49:47 +0000
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <1395257399-359545-45-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-45-git-send-email-arnd@arndb.de>
Message-ID: <20140319204946.GK7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:29:41PM +0100, Arnd Bergmann wrote:
> This adds a new Kconfig option for the Integrator platform to
> choose between ARMv4/ARMv5 based CPUs and those based on ARMv6/ARMv7,
> which is required because we cannot have both classes enabled in the
> same kernel at compile time.

Wouldn't it just be easier to make the older CPUs depend on
!CPU_V6 && !CPU_V7 rather than trying to hack this for each platform?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
