From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 18:32:15 +0000
Subject: [PATCH 1/3] ARM: tegra: Add AHB driver
In-Reply-To: <4F9598AD.2030308@wwwdotorg.org>
References: <1335181043-15348-1-git-send-email-hdoyu@nvidia.com>
 <201204231233.09423.arnd@arndb.de> <4F9598AD.2030308@wwwdotorg.org>
Message-ID: <201204231832.16268.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Stephen Warren wrote:
> I don't know whether it has to be early, but if this driver isn't going
> to be instantiated from device tree, I'd prefer it to be initialized by
> an explicit function call from the boards or common code rather than an
> initcall. It seems a lot easier to keep track of all the initialization
> by doing it explicitly. That said, it's quite possible this API couuld
> be called from say init_machine instead of init_early though.

Having it called from init_machine sounds ok, as long as it still
scans the device tree for the addresses rather than hardcoding.

	Arnd
