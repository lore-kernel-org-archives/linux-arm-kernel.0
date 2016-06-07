From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2016 23:18:10 +0100
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20160607221809.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 05:08:32PM -0400, Jon Mason wrote:
> Many users (and some applications) are expecting the CPU clock speed to
> be output in /proc/cpuinfo (as is done in x86, avr32, c6x, tile, parisc,
> ia64, and xtensa).

Such as what applications?  This is just another meaningless number,
which is just as meaningless as the bogomips number.  It tells you
nothing really about the CPU which should remotely be used for
anything other than user display.  It certainly can't be used for
algorithmic selection.

We have resisted publishing this information for years because not
every ARM CPU is capable of providing this information - for many, we
don't know what the CPU clock rate even is.  I believe it is a mistake
to publish this information.  If userspace wants to select an algorithm,
that needs to be done according to much more information than just the
CPU speed - it needs knowledge of the instruction timings as well, cache
behaviour, etc, and you might as well benchmark an implementation and
select at run time, caching the result.

Since we've never exported this information, it's not a regression
and it's not part of the kernels standard API.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
