From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Aug 2018 17:57:28 +0100
Subject: [PATCH] ARM: drop experimental mark for ARM stack unwinding
In-Reply-To: <20180811103127.21485-1-stefan@agner.ch>
References: <20180811103127.21485-1-stefan@agner.ch>
Message-ID: <20180811165728.GS30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2018 at 12:31:27PM +0200, Stefan Agner wrote:
> ARM stack unwinding is upstream since 2009 and has been proven
> working well. At this time it is the preferred stack unwinding
> support since it also supports Thumb 2. Do not scare people
> and drop the EXPERIMENTAL mark.

Actually, there are still cases where we're missing the annotations -
I've seen them in various oops dumps, but I forget where they are.
What I do remember is that they didn't seem trivial to fix at the
time, so it's still recommended that frame pointers are used if you
want to guarantee getting a debuggable oops dump.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
