From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 13:45:56 +0000
Subject: [PATCH 1/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <2808767.4NLQARgpQ0@flexo>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <201207171307.23514.arnd@arndb.de> <2808767.4NLQARgpQ0@flexo>
Message-ID: <201207171345.56988.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012, Florian Fainelli wrote:
> On Tuesday 17 July 2012 13:07:23 Arnd Bergmann wrote:

> > But is there much difference between the two? How much code would
> > actually get built for one chip but not the other? If all the
> > differences can be run-time detected from the device tree, I
> > think it's better to not have different compile-time options at
> > all.
> 
> The big difference between the two is actually the CPU core, for MCS8140 they 
> used a genuine ARM926EJS and for MCS8142 they actually use a FA526 core.

Ok, I see. That probably is enough difference to justify separate Kconfig
statements, especially since building a combined ARMv4/v5 kernel has some
overhead compared to supporting just one of the two.

	Arnd
