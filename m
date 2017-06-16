From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Jun 2017 12:58:34 +0100
Subject: [PATCH 1/3] ARM: Generalize fncpy implementation
In-Reply-To: <20170615232117.29727-2-f.fainelli@gmail.com>
References: <20170615232117.29727-1-f.fainelli@gmail.com>
 <20170615232117.29727-2-f.fainelli@gmail.com>
Message-ID: <20170616115834.GZ23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 04:21:15PM -0700, Florian Fainelli wrote:
> ARM's fncpy implementation is actually suitable for a large number of
> platforms since the only assumption it makes is just the function's
> alignment (8 bytes) which also happens to fulfil other architectures,
> including but not limited to ARM64.

NAK.  This is really not "generic" because the whole point of this is
that it encapsulates architecture specific knowledge - in the case of
ARM, the fact that bit 1 is used to indicate whether the code is to be
run in Thumb mode or ARM mode.

That clearly does not belong in an asm-generic version of this.

I'm not saying "don't provide an asm-generic" version, I'm saying don't
use the ARM version as an asm-generic implementation, because it is
nothing of the sort.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
