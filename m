From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 12 Jun 2012 23:06:15 +0530
Subject: [PATCH v5 1/7] ARM: davinci, cp_intc: Add irq domain support
In-Reply-To: <4FC919C9.6070107@ti.com>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-2-git-send-email-hs@denx.de> <4FC919C9.6070107@ti.com>
Message-ID: <4FD77E0F.8050907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 6/2/2012 1:06 AM, Sekhar Nori wrote:
> Hi Heiko,
> 
> On 5/30/2012 3:48 PM, Heiko Schocher wrote:
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
>>
>> ---
> 
> On AM18x EVM, with this patch applied and CONFIG_KEYBOARD_GPIO_POLLED=y,
> I get warnings of type:
> 
> irq 0, desc: c0372950, depth: 1, count: 0, unhandled: 0
> 
> ->handle_irq():  c00552f8, handle_bad_irq+0x0/0x23c
> 
> ->irq_data.chip(): c03794e8, 0xc03794e8
> 
> ->action():   (null)
> 
>    IRQ_NOPROBE set
> 
>  IRQ_NOREQUEST set
> 
> 
> They do not come when CONFIG_KEYBOARD_GPIO_POLLED=n. I am yet to debug
> this, but wanted to point out now in case there is anything obvious.

I debugged this a bit more and the good news for you is that spurious
IRQ messages have got nothing to do with your patch. Looks like the
spurious interrupts on interrupt line 0 were always there - just that
they were getting silently ignored earlier. I am still debugging what is
causing these spurious interrupts.

Thanks,
Sekhar
