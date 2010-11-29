From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 19:32:46 +0000
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <4CF3CF33.20407@gmail.com>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011282056.17389.arnd@arndb.de> <4CF3CF33.20407@gmail.com>
Message-ID: <20101129193246.GB20761@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 06:05:07PM +0200, Paulius Zaleckas wrote:
> No he really should NOT use readl/writel. The ONLY difference
> between readl/writel and __raw_readl/__raw_writel is endianess
> conversion. __raw_*l is not doing it. Which to use depend only
> on HW.

Wrong.  readl/writel have barriers too to guarantee ordering between
device accesses and memory accesses.  (device accesses are already
ordered with respect to themselves.)  __raw variants do not
guarantee the relative ordering between memory accesses and device
accesses.
