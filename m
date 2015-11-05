From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Nov 2015 16:15:59 +0100
Subject: Grafting old platform drivers onto a new DT kernel
In-Reply-To: <563B3749.50701@free.fr>
References: <563B3749.50701@free.fr>
Message-ID: <20151105151559.GA16666@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Since I don't have time to rewrite the drivers at the moment, I'm wondering
> if it's possible to "graft" old drivers (they're using the platform API, no
> trace of DT support) onto my small base?

Platform drivers are still usable with DT systems. We used that fact
when converting platform based machines over to DT, one driver at a
time. Look in the git history for kirkwood devices. e.g. somewhere
around v3.7, arch/arm/mach-kirkwood. board-dt.c, and the various
board-*.c files, and the DT files in the usual place.

> Is that a realistic plan? What traps am I likely to fall into?

It is not just the move to DT where things are different. Kernel APIs
are not stable. So your old drivers might not even compile with a
current kernel.

	Andrew
