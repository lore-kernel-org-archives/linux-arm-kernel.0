From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Feb 2015 22:32:55 +0000
Subject: Regression: v4.0-rc1: iMX6: Hummingboard fails due to drivers/clk
 changes
Message-ID: <20150223223255.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I just tried my SolidRun patch set on top of v4.0-rc1, and it fails to
boot.  The kernel itself finishes booting, but it is unable to DHCP (for
root-NFS) - nothing appears on the network.

At first, I thought this would be a network driver bug, but reverting
the mainline changes there didn't fix the regression.  Then I wondered
if it was something in arch/arm/mach-imx, but no.

When reverting all drivers/clk changes (and corresponding include/linux/*.h)
between v3.19 and v4.0-rc1, I find that the regression is fixed.

It seems that some CCF change is causing a regression somewhere in the
clock tree on iMX6 CPUs.

Unfortunately, without networking running, I can't dump the clock tree
to find out what's different, and bisecting will be a major pain (needing
each bisect point to be merged with my patch set, built and tested.)

Has anyone else seen this?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
