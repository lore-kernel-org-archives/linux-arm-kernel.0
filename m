From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 04:48:48 -0700
Subject: [PATCH 3.0-rc2] OMAP: ams-delta: fix broken uevent sysfs entries
In-Reply-To: <201106070316.41099.jkrzyszt@tis.icnet.pl>
References: <201106070316.41099.jkrzyszt@tis.icnet.pl>
Message-ID: <20110614114848.GS3352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [110606 18:15]:
> 
> Removing __initdata tags, introduced by commit 
> bdc58fb950a3a1b0bc3cbd8e23d21ecdde2ac9a2, "arm: omap1: fix a bunch of 
> section mismatches", from corresponding platform_device structures 
> declared in arch/arm/mach-omap1/board-ams-delta.c, corrects the problem 
> for me, which may indicate that their members (.name ?) are still 
> referred to during runtime so they shouldn't be freed after boot.

Sounds like this needs a bit more research where this initdata
gets used?

Tony
