From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Mar 2017 12:36:57 +0100
Subject: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
In-Reply-To: <20170327164308.GK10760@atomide.com>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
 <20170327164308.GK10760@atomide.com>
Message-ID: <20170328113657.GL23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 09:43:09AM -0700, Tony Lindgren wrote:
> Yes problems still remains. I think the immediate fix there is to
> disable kexec during runtime based on some criteria for your use
> case rather than BUG() though. Somehow kexec needs to know if CPU1
> reset is acceptable, then reset CPU1 before kexec.

The only acceptable way to do that is to make the decision when loading
the image(s), and refuse to load the image(s) if kexec is not possible.
(As is already done when dealing with whether we can CPU hot-unplug the
secondary CPUs.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
