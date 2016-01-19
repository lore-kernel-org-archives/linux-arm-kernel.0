From: nbd@openwrt.org (Felix Fietkau)
Date: Tue, 19 Jan 2016 16:38:02 +0100
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
In-Reply-To: <12866783.yJ1maoGsrz@wuerfel>
References: <569D71F3.7000408@openwrt.org>
 <20160119093845.GJ19062@n2100.arm.linux.org.uk>
 <569E0796.9000302@openwrt.org> <12866783.yJ1maoGsrz@wuerfel>
Message-ID: <569E585A.9070009@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-01-19 16:27, Arnd Bergmann wrote:
> On Tuesday 19 January 2016 10:53:26 Felix Fietkau wrote:
>> root at OpenWrt:~# cat /proc/cpuinfo 
>> processor       : 0
>> model name      : ARMv6-compatible processor rev 4 (v6l)
>> BogoMIPS        : 238.38
>> Features        : half thumb fastmult vfp edsp java tls 
>> CPU implementer : 0x41
>> CPU architecture: 7
>> CPU variant     : 0x0
>> CPU part        : 0xb02
>> CPU revision    : 4
>> 
>> processor       : 1
>> model name      : ARMv6-compatible processor rev 4 (v6l)
>> BogoMIPS        : 239.61
>> Features        : half thumb fastmult vfp edsp java tls 
>> CPU implementer : 0x41
>> CPU architecture: 7
>> CPU variant     : 0x0
>> CPU part        : 0xb02
>> CPU revision    : 4
> 
> I guess this means you run with the SMP patches from OpenWRT,
> while upstream only supports uniprocessor mode and presumably doesn't
> have this problem, right?
I tested without SMP and ran into the same user space hangs/crashes.

> I see that Oxnas (supported in OpenWRT but not upstream) has the
> slightly newer ARM11mpcore variant 0 / revision 5 ID. Is it easy for
> you to test if this has the same problem?
I already spoke to Daniel (who maintains that target), and it is equally
affected.

> Interestingly, the documentation at http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0360f/I65012.html
> lists variant:0/revision:4 as the reported values for both r2p0 and r1p0
> and it does not list any core having variant:0/revision:5. 
Heh, interesting.

- Felix
