From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Sep 2016 10:44:51 +0100
Subject: [PATCH v3 7/8] ARM: Move system register accessors to asm/cp15.h
In-Reply-To: <57D2EBE4.4060107@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-8-git-send-email-vladimir.murzin@arm.com>
 <57D2EBE4.4060107@arm.com>
Message-ID: <57D67913.807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, missed this part...

On 09/09/16 18:05, Marc Zyngier wrote:
>>  
>> > +#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
>> > +	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
>> > +#define __ACCESS_CP15_64(Op1, CRm)		\
>> > +	"mrrc", "mcrr", __stringify(p15, Op1, %Q0, %R0, CRm), u64
>> > +
>> > +#define __read_sysreg(r, w, c, t) ({				\
>> > +	t __val;						\
>> > +	asm volatile(r " " c : "=r" (__val));			\
>> > +	__val;							\
>> > +})
>> > +#define read_sysreg(...)		__read_sysreg(__VA_ARGS__)
>> > +
>> > +#define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
>> > +#define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
>> > +
> Shouldn't that be placed after the #ifdef below?
> 

Yes, I'll move it under #ifdef.

Thanks
Vladimir
