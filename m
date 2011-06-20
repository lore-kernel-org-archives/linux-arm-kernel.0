From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 10:56:03 +0100
Subject: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
In-Reply-To: <20110620092334.357.3701.stgit@kaulin>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092334.357.3701.stgit@kaulin>
Message-ID: <20110620095603.GC2082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 02:23:34AM -0700, Tony Lindgren wrote:
> These will be needed when dmtimer platform init code gets split
> for omap1 and omap2+. These will also be needed for separate
> sys_timer init and driver init for the rest of the hardware timers
> in the following patches. No functional changes.

If dmtimer.c is the only user of these definitions, then its quite correct
for them to be in there.  If not, they should be in dmtimer.h in the local
directory - they're private definitions to the .c file and so should not
be exported outside of that .c file.
