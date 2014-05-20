From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 May 2014 09:05:13 -0700
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <5053472.zFAHKQVpbv@wuerfel>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <20140517094636.GP3693@n2100.arm.linux.org.uk>
 <9DBC3527-1961-40DD-8CBA-9A1B5D3003C9@arm.com>
 <5053472.zFAHKQVpbv@wuerfel>
Message-ID: <20140520160512.GE27830@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [140519 04:27]:
> On Saturday 17 May 2014 10:56:02 Catalin Marinas wrote:
> 
> For the case of ARM710T, I think the last remaining user that can be
> configured is mach-integrator, but I don't know if anybody even has that
> CPU tile, or wants to keep using it. If Russell and Linus as the only
> people that have cared about Integrator in the past years want to
> cut down the number of supported CPUs, that would be a different matter:
> quite a number of CPUs are not supported in any other platform.
> Note that the integrator target in qemu does not support any ARM7, only
> StrongARM, ARM9 or later. I also double-checked about mach-clps711x,
> but I'm pretty sure those SoCs are all either ARM710a (no longer supported)
> or ARM720T (quite active).

Hmm I don't think mach-integrator is using ARM710T?

The ARM710T was done by NEC and was used by the Psion MX hardware.
It's very close to ARM720T as far as I remember so might as well keep
the CPU support for it as that's just a few lines of code in the
mainline kernel.

I don't think we have any mach directories using ARM710T, but I
would not be surprised if somebody comes along with device tree
based booting patches for Psion MX at some point.

Regards,

Tony
