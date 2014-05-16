From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 May 2014 13:55:46 +0100
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <1400232598.20342.16.camel@x220>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <8309592.drxAj71PnZ@wuerfel> <1400059550.31197.12.camel@x220>
 <4305975.PvMXZQ020k@wuerfel> <1400232598.20342.16.camel@x220>
Message-ID: <20140516125545.GO3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 11:29:58AM +0200, Paul Bolle wrote:
> Support for ARM710 CPUs was removed in v3.5. But a few lines of ARM710
> specific assembler code were left in the tree. Remove these too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> This minor cleanup was suggested by Arnd. This patch is mostly
> guesswork, as I already told Arnd, since I have never touched ARM
> assembler before (as far as I can remember). Untested too! And this does
> need testing.

NAK.

There was a CPU called the ARM710, it was ARMv3 and it had no Thumb support.

There is also a CPU called the ARM710T, which is ARMv4 and has Thumb support.

These are two completely different CPUs, the former was removed along with
the removal of ARMv3 support.  The latter remains because we still support
ARMv4.

This is a nice instance of arm-soc people thinking that they are somehow
authoritive for core ARM stuff...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
