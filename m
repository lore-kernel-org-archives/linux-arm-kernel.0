From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Sat, 29 Mar 2014 10:52:56 +0100
Subject: [RFC PATCH v2 03/10] ARM: at91: introduce OLD_IRQ_AT91 Kconfig
 option
In-Reply-To: <7407417.cSDunZuEhW@wuerfel>
References: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>
 <1396029548-10928-4-git-send-email-b.brezillon.dev@gmail.com>
 <20140329100639.5ea454bc@skate> <7407417.cSDunZuEhW@wuerfel>
Message-ID: <533697F8.5000903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29/03/2014 10:12, Arnd Bergmann a ?crit :
> On Saturday 29 March 2014 10:06:39 Thomas Petazzoni wrote:
>> Dear Boris BREZILLON,
>>
>> On Fri, 28 Mar 2014 18:59:01 +0100, Boris BREZILLON wrote:
>>
>>> +config OLD_IRQ_AT91
>>> +     bool
>>> +     default false
>> I don't think "default false" is a valid Kconfig construct. It could be
>> "default n", but that's useless since "default n" is the default
>> behavior. So I believe you can simply get rid of that line.

I'll fix it for the next version.

> I think the above is syntactically correct, but it would be highly confusing in
> anyone ever does
>
> config false
> 	def_bool y
>
> ;-)
>
> Aside from that, these three have completely identical meaning:
>
> config OLD_IRQ_AT91
> 	bool
>
> config OLD_IRQ_AT91
> 	def_bool n
>
> config OLD_IRQ_AT91
> 	bool
> 	default n
>
> 	Arnd
>
>
Thanks for the detailled explanation :-).

Best Regards,

Boris
