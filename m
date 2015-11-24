From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 16:40:14 +0000
Subject: suspicious RCU usage on 4.4-rc2 ARM platform
In-Reply-To: <20151124162750.GE20439@e106622-lin>
References: <20151124162750.GE20439@e106622-lin>
Message-ID: <20151124164014.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 04:27:50PM +0000, Juri Lelli wrote:
> I'm hitting these splats while running simple hotplug tests on an ARM
> TC2 platform. The following seems to cure it, but I don't think it never
> made it to mainline:

It looks like it's because of the way we take CPUs offline.  It's a
known problem, one which is not simple to resolve.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
