From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Dec 2015 09:34:12 +0000
Subject: [PATCH 2/2] ARM: Make IPI_CPU_BACKTRACE a "non-secure" SGI
In-Reply-To: <1450430173-26992-3-git-send-email-marc.zyngier@arm.com>
References: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
 <1450430173-26992-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151218093412.GN8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 09:16:13AM +0000, Marc Zyngier wrote:
> Having IPI_CPU_BACKTRACE as SGI15 may not work if the kernel is
> running in non-secure mode and that the secure firmware has
> decided to follow ARM's recommendations that SGI8-15 should
> be reserved for secure purpose.
> 
> Now that we are "only" using SGI0-6, change IPI_CPU_BACKTRACE
> to use SGI7, which makes it more likely to work.

We should add a comment to the enum explaining this, so it's obvious
for the future - best place is after the IPI_CPU_BACKTRACE entry.
Not everyone checks the git logs for these kinds of details.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
