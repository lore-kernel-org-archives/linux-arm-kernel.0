From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Feb 2012 02:00:48 +0100
Subject: [PATCH v6 02/15] ARM: SoC: Add per SoC SMP and CPU hotplug
 operations
In-Reply-To: <20120208234253.GA16313@codeaurora.org>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-3-git-send-email-marc.zyngier@arm.com>
 <20120208234253.GA16313@codeaurora.org>
Message-ID: <3d0d2b3f4a1ffda7057c55655404f696@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 8 Feb 2012 15:42:53 -0800, David Brown <davidb@codeaurora.org>
wrote:
> On Wed, Feb 08, 2012 at 12:30:46AM +0000, Marc Zyngier wrote:
> 
>> +#ifdef CONFIG_SMP
>> +#define soc_smp_init_ops(ops)		.smp_init_ops = &(ops),
>> +#define soc_smp_ops(ops)		.smp_ops = &(ops),
>> +extern void soc_smp_ops_register(struct arm_soc_smp_init_ops *,
>> +				 struct arm_soc_smp_ops *);
>> +#else
>> +#define soc_smp_init_ops(ops)		/* empty */
>> +#define soc_smp_ops(ops)		/* empty */
>> +#define soc_smp_ops_register(a,b)	do {} while(0)
>> +#endif
> 
> I'm not sure if this bothers anyone else, but these macros mess up
> editors that know how to indent C code, since the comma ends up inside
> the macro.  I'm not sure I have a better idea, though.

Emacs seem quite happy when I wrote the code... Shall we re-open the
editor war? ;-)

        M.
-- 
Fast, cheap, reliable. Pick two.
