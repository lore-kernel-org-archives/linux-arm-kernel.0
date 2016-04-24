From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:35:07 +0200
Subject: [GIT PULL] ARM: vexpress: Updates for v4.7
In-Reply-To: <57112A05.3070709@arm.com>
References: <57112A05.3070709@arm.com>
Message-ID: <7123166.4dBrA6hMxj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 18:51:01 Sudeep Holla wrote:

> This time addition of support for Cortex-M based MPS2 system is
> the main highlight. I could not split the patches into platform,
> driver and DT because it's newly added and have Kconfig/Makefile
> dependency.

I don't get it. Why is there a dependency between the three things?

Usually nothing breaks by adding any of those things, so the only
dependency is that you need them all in order to make the platform
work, but that is not enough reason to put them into a common branch.

Please respin this. When you do, it probably makes sense to
separate the changes for vexpress from the new MPS2 platform
into distinct branches.

I see you got the Acks from the clockevent and serial maintainers,
but I don't see why they did not just merge those.

	Arnd
