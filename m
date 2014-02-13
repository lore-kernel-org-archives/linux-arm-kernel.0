From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Feb 2014 18:21:06 +0000
Subject: [BISECTED] ssh - Received disconnect from x.x.x.x: 2: Bad packet
 length 3149594624
In-Reply-To: <52FD08D1.3030405@gmail.com>
References: <52FD08D1.3030405@gmail.com>
Message-ID: <20140213182105.GN13576@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivo,

Thanks for bisecting this.

On Thu, Feb 13, 2014 at 06:02:57PM +0000, Ivaylo Dimitrov wrote:
> Since next-21012014 I started to receive "Received disconnect from 
> x.x.x.x: 2: Bad packet length 3149594624" errors when trying to 
> establish ssh session over wifi to my N900, running Maemo 5. I bisected 
> and it turned out that commit dce5c9e35bc4085bd33eccdb8c9ec5a643507a14 
> "ARM: 7928/1: kconfig: select HAVE_EFFICIENT_UNALIGNED_ACCESS for CPUv6+ 
> && MMU" is the first bad. There is nothing related in either dmesg or 
> syslog on the device. Reverting that commit on 3.14-rc1 make those 
> errors disappear.

That's certainly unexpected. The n900 has (iirc) a Cortex-A8, which as an
ARMv7 core, can perform unaligned accesses to normal, cacheable memory in
hardware.

Can you provide your .config and/or any information about your network chip
please? There's a chance that the driver is doing something odd.

Cheers,

Will
