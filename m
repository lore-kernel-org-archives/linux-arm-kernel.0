From: nm@ti.com (Nishanth Menon)
Date: Tue, 04 Jan 2011 12:52:54 -0600
Subject: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined
	reference'
In-Reply-To: <d7800f7a785b294a089ea8772607d232@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
	<4D236AFB.2050301@ti.com>
	<2a7055e7c506648a2a48a0454756687b@mail.gmail.com>
	<d7800f7a785b294a089ea8772607d232@mail.gmail.com>
Message-ID: <4D236C86.10703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar had written, on 01/04/2011 12:50 PM, the following:
[..]
>>>> +static inline struct voltagedomain
>>> *omap_voltage_domain_lookup(char *name)
>>>> +{
>>>> +	return NULL;
>>> the omap_voltage_domain_lookup uses ERR_PTR() for all return
>> values
>>> which are handled by the callers with IS_ERR()
>>>
>>> I think you should return ERR_PTR(-EINVAL)
>>>
>> The expected return value is pointer type and hence used
>> NULL.
> 
> 'ERR_PTR(-EINVAL)' is also ok.
looking at the implementation (when CONFIG_PM is enabled),
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/voltage.c;h=ed6079c94c57bae30f599bbad5e25a38fc676fa8;hb=refs/heads/omap-for-linus#l1487
ERR_PTR(-EINVAL) looks more appropriate to me.

-- 
Regards,
Nishanth Menon
