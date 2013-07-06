From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 6 Jul 2013 23:36:48 +0200
Subject: [PATCH 1/6] ARM: OMAP2+: Remove board-4430sdp.c
In-Reply-To: <20130706131057.GU21614@n2100.arm.linux.org.uk>
References: <20130517191304.468.73487.stgit@localhost>
 <20130520095447.GR21614@n2100.arm.linux.org.uk>
 <20130706131057.GU21614@n2100.arm.linux.org.uk>
Message-ID: <201307062336.49066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 July 2013, Russell King - ARM Linux wrote:
> Oh wait, why don't I get to choose my "debug console UART" on an AT91?
> Maybe AT91 should move their debug uart selection into this menu as well,
> and maybe the Versatile Express options too, because they're all to do
> with selecting the UART to be used.  Please... some sane thought would
> be really good here.
> 
> Oh my god, you're not the only ones.  Arnd/Olof, who started this madness
> and why haven't you already stepped on it?  Right, I'm fixing this in
> this merge window.  Everything is moving under the original choice menu
> as it was intended to be.

Sorry, I missed that this was going on, and I absolutely agree with your
sentiment. From what I can tell from the git log, Tegra was the first
to have the separate choice statement, after it just move its
options from mach-tegra/Kconfig into the Kconfig.debug. OMAP followed
with the same method and I think from there people just copied it.

I can understand why one wants to have some more structure in the list,
given that i.MX alone has 37 options for UART addresses, but we first
need to have a consistent method of configuring the addresses.

	Arnd
