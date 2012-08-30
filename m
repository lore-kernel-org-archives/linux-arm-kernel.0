From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Thu, 30 Aug 2012 20:18:49 +0000
Subject: [PATCH - 2/2] arm: disable caches based on config option
In-Reply-To: <alpine.LFD.2.02.1208301156390.1784@xanadu.home>
References: <1346337826-27232-1-git-send-email-m-karicheri2@ti.com>
 <1346337826-27232-2-git-send-email-m-karicheri2@ti.com>
 <alpine.LFD.2.02.1208301156390.1784@xanadu.home>
Message-ID: <3E54258959B69E4282D79E01AB1F32B7041AD7AD@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Submitted. Thanks.

Murali Karicheri
Software Design Engineer


>> -----Original Message-----
>> From: Nicolas Pitre [mailto:nicolas.pitre at linaro.org]
>> Sent: Thursday, August 30, 2012 11:59 AM
>> To: Karicheri, Muralidharan
>> Cc: Russell King - ARM Linux; tony at atomide.com; Shilimkar, Santosh; wim at iguana.be;
>> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
>> Subject: Re: [PATCH - 2/2] arm: disable caches based on config option
>> 
>> On Thu, 30 Aug 2012, Murali Karicheri wrote:
>> 
>> > CONFIG_CPU_ICACHE_DISABLE and CONFIG_CPU_DCACHE_DISABLE are available
>> > to allow disabling of D-Cache and I-Cache. However the compressed version
>> > of head.S currently doesn't check these variables. This patch will fix
>> > this issue and is written similar to the uncompressed version of head.S
>> >
>> > Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> 
>> Acked-by: nicolas Pitre <nico@linaro.org>
>> 
>> You may submit your patch to http://www.arm.linux.org.uk/developer/patches/.
>> 
>> 
>> > ---
>> >  arch/arm/boot/compressed/head.S |    6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> > index b8c64b8..e1d2124 100644
>> > --- a/arch/arm/boot/compressed/head.S
>> > +++ b/arch/arm/boot/compressed/head.S
>> > @@ -659,6 +659,12 @@ __armv7_mmu_cache_on:
>> >  #ifdef CONFIG_CPU_ENDIAN_BE8
>> >  		orr	r0, r0, #1 << 25	@ big-endian page tables
>> >  #endif
>> > +#ifdef CONFIG_CPU_DCACHE_DISABLE
>> > +		bic	r0, r0, #1 << 2
>> > +#endif
>> > +#ifdef CONFIG_CPU_ICACHE_DISABLE
>> > +		bic	r0, r0, #1 << 12
>> > +#endif
>> >  		orrne	r0, r0, #1		@ MMU enabled
>> >  		movne	r1, #0xfffffffd		@ domain 0 = client
>> >  		mcrne	p15, 0, r3, c2, c0, 0	@ load page table pointer
>> > --
>> > 1.7.9.5
>> >
