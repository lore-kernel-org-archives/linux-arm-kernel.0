From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Apr 2015 18:22:12 +0200
Subject: [RFC 5/6] usb: gadget: atmel_usba: use atmel_io.h to provide
 on-chip IO
In-Reply-To: <553FA9DE.20406@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-6-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115647.GD16148@samfundet.no>
 <20150427205529.GH25136@saruman.tx.rr.com> <553FA9DE.20406@codethink.co.uk>
Message-ID: <553FB3B4.5010708@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/04/2015 17:40, Ben Dooks a ?crit :
> 
>>>>
>>>> /* Register access macros */ -#ifdef CONFIG_AVR32 -#define
>>>> usba_io_readl	__raw_readl -#define usba_io_writel	__raw_writel 
>>>> -#define usba_io_writew	__raw_writew -#else -#define
>>>> usba_io_readl	readl_relaxed -#define usba_io_writel
>>>> writel_relaxed -#define usba_io_writew	writew_relaxed -#endif 
>>>> +#define usba_io_readl	atmel_oc_readl +#define usba_io_writel
>>>> atmel_oc_writel +#define usba_io_writew	atmel_oc_writew
>>>
>>> Same comment as earlier patch, it would be nice to remove the
>>> define usba_io_{read,write}{l,w} defines in a follow-up patch.
> 
>> I'm fine with this too. Is this targetted at v4.2 ?
> 
> Yes, although we may move it to the soc specific include directories
> to avoid adding more to linux/

BTW, Ben, what _oc_ stands for in the new macro name?

Bye,
-- 
Nicolas Ferre
