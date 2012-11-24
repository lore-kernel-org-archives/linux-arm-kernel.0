From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 24 Nov 2012 19:10:24 +0100
Subject: [PATCH 3/4] ARM: Dove: Convert to DT GPIO and pinctrl
In-Reply-To: <20121124150004.GQ15800@titan.lakedaemon.net>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121124023942.GO15800@titan.lakedaemon.net>
 <20121124080240.3f600e89@skate>
 <20121124150004.GQ15800@titan.lakedaemon.net>
Message-ID: <20121124191024.4b5d5b4c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sat, 24 Nov 2012 10:00:04 -0500, Jason Cooper wrote:

> Yes, so that's what I thought happened.  This would have made orion/dt
> depend upon mvebu/everything.  It already had two other dependencies.
> Not ideal.
> 
> The good thing is, the build is not broken.  Once v3.8-rc1 drops with
> all of our stuff merged, I'll post a fixup patch adding this back in.

It unfortunately means that Dove will be basically unbootable in
3.8-rc1, as the driver will not be clk_get()ing its gatable clock, and
the clock driver will disable it. Maybe we can just live with it, I
don't know.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
