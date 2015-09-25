From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Sep 2015 13:56:50 +0200
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56051393.2080709@free.fr>
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56051393.2080709@free.fr>
Message-ID: <4499716.JusW7FEoAA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 11:27:47 Mason wrote:
> I see that defining ARCH_MULTIPLATFORM selects AUTO_ZRELADDR
> Is that what is supposed to make Makefile.boot not required?
> 

Javier explained this.

> On an unrelated topic, someone wrote
> select CPU_USE_DOMAINS if MMU
> in my platform Kconfig. But looking at arm/mm/Kconfig,
> it looks like it is not set for other V7 platforms.
> Is this an obsolete feature that I should remove?

Domains are useful in principle, but we stopped using them for
v6 and v7 CPUs as of 247055aa21ffef1 ("ARM: 6384/1: Remove the
domain switching on ARMv6k/v7 CPUs") and the select needs to
be removed from your platform.

	Arnd
