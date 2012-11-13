From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Nov 2012 14:26:13 -0800
Subject: [PATCH 8/8] ARM: OMAP: Move plat/dmtimer.h to plat-omap/dmtimer.h
In-Reply-To: <1352830403-1706-9-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-9-git-send-email-jon-hunter@ti.com>
Message-ID: <20121113222613.GM6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121113 10:15]:
> Move plat/dmtimer.h to plat-omap/dmtimer.h in order to support a single
> zImage for ARM devices.

Let's skip this one for now as it turns out this solution won't
work either for multiplatform without adding nasty hacks to
arch/arm/Makefile to include arch/arm/plat-omap.

Sorry I don't have any real solution in mind other than making
the remaining dmtimer.h users to use Linux generic timer functions,
or pass the dmtimer functions in platform_data for now.

Regards,

Tony
