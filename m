From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 15:48:56 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <87k1zc3fxp.fsf@free-electrons.com>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
Message-ID: <20171030154855.GO20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 02:48:02PM +0100, Gregory CLEMENT wrote:
> Hi Russell,
> 
> So I tested the branch fixes in your git tree.
> 
> After doing a "make multi_v7_defconfig; make zImage", I got the message
> "arm-linux-gnueabi-ld: error: zImage file size is incorrect" you added
> in the commit "ARM: verify size of zImage".
> 
> It is the same with mvebu_v7_defconfig, so I wonder wich with
> configuration this patch was tested ?

I heard a similar report from Olof when his autobuilder produced 100%
failure.  I tried one of the same defconfig's that Olof tried here,
and didn't see the failure.  It passes my build tests here, and it
also passes kernelci's build tests too.

So, I _think_ it's got something to do with the toolchain versions
being used, but at the moment I'm just guessing.  I've no real idea,
because I've no idea what's causing the failure at the moment.

Olof said that he'd send me one of the build trees, but I'm still
waiting.

What I need is a tarball of the objects from arch/arm/boot/compressed
to work out what's going on - when grabbing that, it may be a good
idea to first disable the assert in the linker script, so that the
resulting "vmlinux" in that directory remains for analysis.  Or...
someone else needs to work out what's going on and report back.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
