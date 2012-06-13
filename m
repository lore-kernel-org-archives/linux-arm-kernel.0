From: hs@denx.de (Heiko Schocher)
Date: Wed, 13 Jun 2012 11:50:04 +0200
Subject: [PATCH v5 1/7] ARM: davinci, cp_intc: Add irq domain support
In-Reply-To: <4FD77E0F.8050907@ti.com>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-2-git-send-email-hs@denx.de> <4FC919C9.6070107@ti.com>
 <4FD77E0F.8050907@ti.com>
Message-ID: <4FD8624C.8010605@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nori,

On 12.06.2012 19:36, Sekhar Nori wrote:
> Hi Heiko,
>
> On 6/2/2012 1:06 AM, Sekhar Nori wrote:
>> Hi Heiko,
>>
>> On 5/30/2012 3:48 PM, Heiko Schocher wrote:
>>> Signed-off-by: Heiko Schocher<hs@denx.de>
>>> Cc: davinci-linux-open-source at linux.davincidsp.com
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Wolfgang Denk<wd@denx.de>
>>> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
>>>
>>> ---
>>
>> On AM18x EVM, with this patch applied and CONFIG_KEYBOARD_GPIO_POLLED=y,
>> I get warnings of type:
>>
>> irq 0, desc: c0372950, depth: 1, count: 0, unhandled: 0
>>
>> ->handle_irq():  c00552f8, handle_bad_irq+0x0/0x23c
>>
>> ->irq_data.chip(): c03794e8, 0xc03794e8
>>
>> ->action():   (null)
>>
>>     IRQ_NOPROBE set
>>
>>   IRQ_NOREQUEST set
>>
>>
>> They do not come when CONFIG_KEYBOARD_GPIO_POLLED=n. I am yet to debug
>> this, but wanted to point out now in case there is anything obvious.

Hups, seems I missed your EMail :-(

> I debugged this a bit more and the good news for you is that spurious
> IRQ messages have got nothing to do with your patch. Looks like the

Good :-)

> spurious interrupts on interrupt line 0 were always there - just that
> they were getting silently ignored earlier. I am still debugging what is
> causing these spurious interrupts.

Hmm.. I did not see this on the enbw_cmc board. Maybe I can try it
on the TMDXEXP1808L board, but I must admit, that I am currently lacking
time, because of an accident ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
