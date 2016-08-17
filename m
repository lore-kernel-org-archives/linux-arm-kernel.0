From: peter.chen@nxp.com (Peter Chen)
Date: Wed, 17 Aug 2016 08:28:06 +0000
Subject: [PATCH] ARM: irq_work: Do not attempt to IPI on non IPI-capable HW
In-Reply-To: <57B41B90.3050204@arm.com>
References: <1471361210-29914-1-git-send-email-marc.zyngier@arm.com>
 <CAL411-pUUdxN_d76FaXYGtEd7Seewnrin=x2mFEbi1Z48zSRvg@mail.gmail.com>
 <57B41523.6030202@arm.com>
 <VI1PR04MB1455E9F56D0EDA0558CC84508B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
 <57B41B90.3050204@arm.com>
Message-ID: <VI1PR04MB14558618D41FFF0BA4616BD08B140@VI1PR04MB1455.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
>>>>
>>>> Why not using is_smp as condition, it is more strict.
>>>>
>>>> if (is_smp())
>>>>     return !!__smp_cross_call;
>>>> else
>>>>     return false;
>>>
>>> What's the gain? We're trying to check whether we can actually
>>> deliver an IPI. Why should we gate it by finding out whether we're smp_on_up or
>not?
>>>
>>
>> If UP system with CONFIG_SMP enabled, the __smp_cross_call is not
>> NULL, but the IPI is not capable. Or am I missing something?
>
>Take an OMAP3 system. It is UP,  and doesn't have a GIC, so __smp_cross_call will
>be NULL. Yet, it boots with a generic multi-platform kernel, with SMP on.
>

Are there any UP platforms which have GIC? If there is, we may be in trouble with only
depends on CONFIG_SMP.

Peter
