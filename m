From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Feb 2017 20:19:33 +0000
Subject: ERROR: Recursive variable `CC_OPTION_CFLAGS' references itself
 (eventually). Stop.
In-Reply-To: <CAOH+1jEOYjdxsO1uh63iXN+TiaLiSNLNk+VE2kmh+=ZnxD2hcA@mail.gmail.com>
References: <CAOH+1jEOYjdxsO1uh63iXN+TiaLiSNLNk+VE2kmh+=ZnxD2hcA@mail.gmail.com>
Message-ID: <20170211201933.GQ27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 01:37:12AM +0530, Bhumika Goyal wrote:
> Hi,
> 
> I ran the command "./make.cross ARCH=arm arch/arm/" on my 64 bit x86
> machine but got the following error:

I don't know what "make.cross" is supposed to do, but if it's invoking
the kernel build like this:

make CROSS_COMPILE=... ARCH=arm arch/arm/

then that is wrong - although we support building subdirectories using
that notation, that does not apply to arch/<$ARCH>/ subdirectories.  The
makefile in there is designed to be included into the kernel's top level
makefile, and is not a stand-alone makefile in the same way as (eg)
fs/Makefile, fs/ext4/Makefile or arch/arm/kernel/Makefile.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
