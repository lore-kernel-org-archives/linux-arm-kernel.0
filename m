From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 12 Dec 2013 13:07:58 -0500 (EST)
Subject: gcc miscompiles csum_tcpudp_magic() on ARMv5
In-Reply-To: <20131212172049.GU4360@n2100.arm.linux.org.uk>
References: <1386850444.22947.46.camel@sakura.staff.proxad.net>
 <20131212124015.GL4360@n2100.arm.linux.org.uk>
 <1386855390.22947.68.camel@sakura.staff.proxad.net>
 <20131212144853.GO4360@n2100.arm.linux.org.uk>
 <1386860657.25449.3.camel@sakura.staff.proxad.net>
 <20131212154110.GQ4360@n2100.arm.linux.org.uk> <20131212160426.GD31816@1wt.eu>
 <20131212164748.GS4360@n2100.arm.linux.org.uk> <20131212171108.GA2337@1wt.eu>
 <20131212172049.GU4360@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1312121305240.15948@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Dec 2013, Russell King - ARM Linux wrote:

> static inline __sum16 csum_fold(__wsum sum)
> {
>         __asm__(
>         "add    %0, %1, %1, ror #16     @ csum_fold"
>         : "=r" (sum)
>         : "r" (sum)
>         : "cc");
>         return (__force __sum16)(~(__force u32)sum >> 16);
> }

There is no longer any flag updates so you should remove "cc" from the 
clobber list as well.


Nicolas
