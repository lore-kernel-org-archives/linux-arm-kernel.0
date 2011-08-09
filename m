From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Wed, 10 Aug 2011 01:06:55 +0300
Subject: [PATCH] ARM errata: Possible cache data corruption with
	hit-under-miss enabled
In-Reply-To: <20110808132631.GA670@e102109-lin.cambridge.arm.com>
References: <1312785148-32531-1-git-send-email-siarhei.siamashka@gmail.com>
	<20110808100233.GG29226@e102109-lin.cambridge.arm.com>
	<CACY+gR2_Rf7dh91vagJfEB=qgALJf4nigJbFQJz--DweQkZ+Qw@mail.gmail.com>
	<20110808132631.GA670@e102109-lin.cambridge.arm.com>
Message-ID: <CACY+gR2oofw0wLrPTVyLmmFtLOV347tVnfBicfgOYegi1vEzMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2011 at 4:26 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Aug 08, 2011 at 12:43:00PM +0100, Siarhei Siamashka wrote:
>> On Mon, Aug 8, 2011 at 1:02 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, Aug 08, 2011 at 07:32:28AM +0100, Siarhei Siamashka wrote:
>> >> From: Catalin Marinas <catalin.marinas@arm.com>
>> >>
>> >> This patch is a workaround for the 364296 ARM1136 r0pX erratum (possible
>> >> cache data corruption with hit-under-miss enabled). It sets the
>> >> undocumented bit 31 in the auxiliary control register and the FI bit in
>> >> the control register, thus disabling hit-under-miss without putting the
>> >> processor into full low interrupt latency mode.
>> >>
>> >> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> >> Tested-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
>> >
>> > I haven't pushed this workaround in the past as I wasn't sure there is
>> > production hardware affected. I recall you mentioned Nokia N800, do you
>> > know which CPU revision does this have?
>>
>> [ ? ?0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2
>> (ARMv6TEJ), cr=00e5387f
>> [ ? ?0.000000] CPU: VIPT aliasing data cache, unknown instruction
>> cache
>> [ ? ?0.000000] Machine: Nokia N810
>> [ ? ?0.000000] Memory policy: ECC disabled, Data cache writeback
>> [ ? ?0.000000] OMAP2420
>>
>> # cat /proc/cpuinfo
>> Processor ? ? ? : ARMv6-compatible processor rev 2 (v6l)
>> BogoMIPS ? ? ? ?: 213.72
>> Features ? ? ? ?: swp half thumb fastmult vfp edsp java
>> CPU implementer : 0x41
>> CPU architecture: 6TEJ
>> CPU variant ? ? : 0x0
>> CPU part ? ? ? ?: 0xb36
>> CPU revision ? ?: 2
>>
>> Hardware ? ? ? ?: Nokia N810
>> Revision ? ? ? ?: 0000
>> Serial ? ? ? ? ?: 0000000000000000
> ...
>> Would you be so kind to update the patch?
>
> OK, I'll update it and post the patch in the next day or so.

Thanks a lot. I'll be sure to test it and respond to confirm that it
works fine (or not).

-- 
Best regards,
Siarhei Siamashka
