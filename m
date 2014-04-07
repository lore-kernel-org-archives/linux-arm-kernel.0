From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 10:03:52 +0100
Subject: [PATCH] arm/twd: use smp_twd clock even with DT
In-Reply-To: <1396813085-15363-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1396813085-15363-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <20140407090352.GV7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 09:38:05PM +0200, Gilles Chanteperdrix wrote:
> Booting Linux 3.14 on Pandaboard currently gets the following
> message displayed:
> 
> smp_twd: clock not found -2
> 
> Whereas an "smp_twd" clock exists for omap4. The following change
> avoids this.

NAK.  The TWD has required this clock for 15 months, and all OMAP has
to do is to supply the clock in its DT description.  Why is OMAP not
supplying this clock?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
