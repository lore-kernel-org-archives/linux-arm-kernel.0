From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Jan 2012 09:27:04 +0000
Subject: [V3 3/6] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <1322634646-4460-1-git-send-email-jtzhou@marvell.com>
References: <1322634646-4460-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120114092704.GP1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 02:30:46PM +0800, Jett.Zhou wrote:
> Since the regmap of rtc on sa1100, pxa and mmp Marvell soc families are
> almost the same, so re-arch the rtc-sa1100 to support them.

Err.  This looks wrong.  What's the clk stuff doing in here?  It seems
to be completely unused by the driver, and then both PXA and SA1100
end up having to provide a 'dummy' clk structure to satisfy this
additional useless code.

If it's a case that "every driver must use a clk" then there's a policy
error somewhere.
