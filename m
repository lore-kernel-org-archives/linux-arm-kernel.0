From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2012 22:40:43 +0000
Subject: [PATCH 1/2] ARM: EXYNOS: add support GPIO for EXYNOS5250
In-Reply-To: <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
References: <1328025040-4751-1-git-send-email-kgene.kim@samsung.com>
 <1328025040-4751-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20120131224043.GD8338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 12:50:39AM +0900, Kukjin Kim wrote:
> From: Sangsu Park <sangsu4u.park@samsung.com>
> 
> This patch adds follwing.
> - IO-map for EXYNOS5250 GPIO support
> - EXYNOS5250 GPIO bank size/number definitions
> - memory map definition for S5P GPIO4
> 
> Signed-off-by: Sangsu Park <sangsu4u.park@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Do you actually need these static mapping definitions?  The samsung
gpiolib initialization is called from a core_initcall(), and at this
time ioremap() is fully capable of working.
