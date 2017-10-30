From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 17:13:53 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <CAK8P3a37pQZPzLbh_qCtDqz0=Ends+nnV3-Y1KJKZVxiRErFfQ@mail.gmail.com>
References: <20171020200231.1355569-1-arnd@arndb.de>
 <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <CAK8P3a0_-YOvPUqZTb+LoU+wCBhy=zCxmk4HProPJY+udbri9Q@mail.gmail.com>
 <20171030155029.GP20805@n2100.armlinux.org.uk>
 <CAK8P3a37pQZPzLbh_qCtDqz0=Ends+nnV3-Y1KJKZVxiRErFfQ@mail.gmail.com>
Message-ID: <20171030171353.GD27404@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 06:01:44PM +0100, Arnd Bergmann wrote:
> Right, either fail the build or use the workaround from the gcc bugzilla,
> passing -fno-store-merging to the broken compilers avoids the problem
> reliably at the cost of slightly worse code. For the decompressor, we might
> also get away with passing -march=armv5t (not armv5te), which has
> experimentally been found to avoid the problem and produce better code
> than "-march=armv6 -fno-store-merging" as it avoids the strd instruction
> but not other store merging.

Depends how important the compilers are...

We currently refuse to build using these compilers:

gcc = 3.x where x < 3
gcc = 4.x where x < 3 if unwinding is enabled
gcc = 4.8.x where x < 3

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
