From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 09 Mar 2015 21:15:01 +0100
Subject: [PATCH v3 5/9] mtd: pxa3xx_nand: add support for the Marvell
 Berlin nand controller
In-Reply-To: <54FD860F.2000008@free-electrons.com> (Ezequiel Garcia's message
 of "Mon, 09 Mar 2015 08:37:51 -0300")
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>
 <54FA6DFC.1070904@free-electrons.com> <87oao3xvh8.fsf@free.fr>
 <54FCAF6C.7010902@free-electrons.com> <87ioebxhc7.fsf@free.fr>
 <54FD860F.2000008@free-electrons.com>
Message-ID: <877fuqx70a.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:

>>> Which flash do you have there?
>> The one with 0xba20 id as I said, which is AFAIK a Numonyx NAND02GR4B2C.
>> 
>
> $ grep "0xBA" drivers/mtd/nand/nand_ids.c
> EXTENDED_ID_NAND("NAND 256MiB 1,8V 16-bit", 0xBA, 256, LP_OPTIONS16),
>
> Seems already supported by the NAND core. The MTD way of probing
> a non-ONFI device is by using the IDs in nand_ids.c. Additional
> configuration (timings in this case) is applied between the nand_scan_ident()
> and nand_scan_tail() calls.

Ok, agreed.

I've seen your answer in the "rework timings setup" mail thread. I think you
have perfectly understood what bothers me :)

Cheers.

-- 
Robert
