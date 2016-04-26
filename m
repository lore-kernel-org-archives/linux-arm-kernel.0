From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Apr 2016 09:56:22 -0700
Subject: [PATCH 1/2] ARM: dts: omap5-board-common: fix ldo1_reg and
 ldo4_reg ranges
In-Reply-To: <1460973967-25077-1-git-send-email-tomi.valkeinen@ti.com>
References: <1460973967-25077-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20160426165622.GB5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160418 03:07]:
> ldo4_reg is connected to DSS, and should always be 1.8V. However the
> The dts defines a range of 1.5V-1.8V, which requires somethings to set
> the actual voltage at runtime. Currently we set the voltage in omapdss
> driver.
> 
> As the voltage must always be 1.8V, let's just define the range to 1.8V
> so that the driver doesn't need to deal with the voltage. In fact, the
> driver should not touch the voltage, except in the cases where the
> voltage needs to be changed at runtime.

Thanks applying both into omap-for-v4.6/fixes-rc5. Feel free to merge
commit 5607959a4d5b54dcc9a3572bdbf967dfda88ae66 into your DSS tree
too for v4.7 in case it gets too late for these fixes for v4.6-rc.

Regards,

Tony
