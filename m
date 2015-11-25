From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 12:56:34 +0000
Subject: [PATCH] ARM: avoid SMP DT initialisation on UP-only capable
 systems
In-Reply-To: <1448455831.3689.55.camel@pengutronix.de>
References: <E1a1XXS-00060O-GS@rmk-PC.arm.linux.org.uk>
 <20151125113538.GB12434@leverpostej>
 <20151125114908.GI8644@n2100.arm.linux.org.uk>
 <1448455831.3689.55.camel@pengutronix.de>
Message-ID: <20151125125634.GK8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 01:50:31PM +0100, Lucas Stach wrote:
> What we do in barebox is to look into the SCU to find out how many CPU
> cores are actually present and fix up the DT passed to the kernel
> accordingly by deleting any superfluous CPU nodes. This satisfies both
> the need to keep the required DT source files to a minimum, while also
> providing correct information to the kernel.

... which is a function of the boot loader, but not all boot loaders
do this.  So, if we're using u-boot, what option do we have?

I've never been able to successfully build and boot uboot myself (it
always fails one way or another with my toolchains - if I get it to
link, it silently fails on the hardware, but if someone else builds
it for me from exactly the same source, it works fine) so count me
out of fixing uboot in this regard.

Note that it's not that the kernel doesn't work, it's just that people
are complaining that they see warnings from the kernel during their
boot.  So, unless we're going to start providing iMX6S and iMX6D
specific DT blobs (which will double the number of .dtb files we end
up with on iMX6), I think we're stuck with users complaining about
this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
