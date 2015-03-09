From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 09 Mar 2015 08:37:51 -0300
Subject: [PATCH v3 5/9] mtd: pxa3xx_nand: add support for the Marvell
 Berlin nand controller
In-Reply-To: <87ioebxhc7.fsf@free.fr>
References: <1425555085-29531-1-git-send-email-antoine.tenart@free-electrons.com>	<1425555085-29531-6-git-send-email-antoine.tenart@free-electrons.com>	<54FA6DFC.1070904@free-electrons.com>
 <87oao3xvh8.fsf@free.fr>	<54FCAF6C.7010902@free-electrons.com>
 <87ioebxhc7.fsf@free.fr>
Message-ID: <54FD860F.2000008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2015 07:19 PM, Robert Jarzmik wrote:
> Ezequiel Garcia <ezequiel.garcia@free-electrons.com> writes:
> 
>>> I think you'll kill the zylonite board, and I'll nack it if that's the case. At
>>> least that's what happened when I tried to use onfi default values last time in
>>> barebox development.
>>>
>>> I can test your changes, but if the specific zylonite nand (ie. nand id 0xba20,
>>> ie. pxa310 embedded flash) gets broken, I'm against the removal of the legacy
>>> timings removal.
>>>
>>
>> I'm not speaking of any timing params here, but about the flash
>> identification.
>>
>> Which flash do you have there?
> The one with 0xba20 id as I said, which is AFAIK a Numonyx NAND02GR4B2C.
> 

$ grep "0xBA" drivers/mtd/nand/nand_ids.c
EXTENDED_ID_NAND("NAND 256MiB 1,8V 16-bit", 0xBA, 256, LP_OPTIONS16),

Seems already supported by the NAND core. The MTD way of probing
a non-ONFI device is by using the IDs in nand_ids.c. Additional
configuration (timings in this case) is applied between the nand_scan_ident()
and nand_scan_tail() calls.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
