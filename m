From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2015 18:02:26 +0100
Subject: possible reason: unannotated irqs-off
In-Reply-To: <55FC3587.7010601@ti.com>
References: <55FC3587.7010601@ti.com>
Message-ID: <20150918170226.GK21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:02:15PM -0400, Murali Karicheri wrote:
> While chasing a fix for a deadlock in netcp driver with debug options
> enabled, i bumped on another warning shown below.. Looks like I need to
> enable CONFIG_IRQSOFF_TRACER as well to get rid of this. Have anyone seen
> this? My google search showed me some connection with this option and I
> enabled it as well and I don't see the warning anymore. Any idea if this is
> a false alarm or a real bug? Looks like I need to enable
> CONFIG_IRQSOFF_TRACER as well. If so, I can send a patch. Either way let me
> know.

Do you have this commit applied?

commit 3302caddf10ad50710dbb7a94ccbdb3ad5bf1412
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Thu Aug 20 16:13:37 2015 +0100

    ARM: entry: efficiency cleanups

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
