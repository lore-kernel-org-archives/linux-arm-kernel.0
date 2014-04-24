From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Apr 2014 18:44:56 +0100
Subject: L2C boot crash on BCM Capri
In-Reply-To: <7hlhuuprkc.fsf@paris.lan>
References: <CAGa+x84pQLkD5_-xZKaEq67ETAtAaCB4Ryt_F-ocwX_wmh=tTA@mail.gmail.com>
 <7hlhuuprkc.fsf@paris.lan>
Message-ID: <20140424174456.GV26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 10:26:11AM -0700, Kevin Hilman wrote:
> [    0.100000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.110000] L2C-310 full line of zeros enabled for Cortex-A9
> [    0.110000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.120000] Unhandled fault: imprecise external abort (0xc06) at 0x44a42d67

The unfortunate thing about imprecise external aborts is that they don't
tell us what went wrong - we have to guess.

My guess would be that something isn't wired up correctly between the
Cortex-A9 and L2 controller in Broadcom SoCs.  You could try disabling
the clock gating/standby mode - I doubt it's the FLZ feature as that
also requires the Cortex-A9 configuration to be changed as well, which
wouldn't have happened at the point this fault occurred.

Also, it's possible that BRESP could cause it.  Try disabling each in
turn and see what effect they have...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
