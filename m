From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Jul 2013 20:11:34 +0530
Subject: [PATCH] ARM: omap2: add select of TI_PRIV_EDMA
In-Reply-To: <201307101636.57623.arnd@arndb.de>
References: <1373359054-5007-1-git-send-email-olof@lixom.net>
 <20130710075017.GM5523@atomide.com> <51DD6FA9.8080908@ti.com>
 <201307101636.57623.arnd@arndb.de>
Message-ID: <51DD729E.9060402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/10/2013 8:06 PM, Arnd Bergmann wrote:
> On Wednesday 10 July 2013, Sekhar Nori wrote:
>> On 7/10/2013 1:20 PM, Tony Lindgren wrote:
>>> * Olof Johansson <olof@lixom.net> [130709 01:44]:
>>>> "ARM: OMAP: build mach-omap code only if needed" moved around the
>>>> ARCH_OMAP2PLUS stanza, but accidentally dropped the seleciton of
>>>> TI_PRIV_EDMA in the process. Add it back.
>>>>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>>> Signed-off-by: Olof Johansson <olof@lixom.net>
>>
>> Thinking more, I do not think we should be selecting TI_PRIV_EDMA for
>> OMAP2PLUS. There is no part of mach-omap2 that depends directly on
>> TI_PRIV_EDMA being enabled.
>>
>> Instead, TI_PRIV_EDMA should be selected by the DMA engine driver as
>> done in the patch here:
>>
>> http://www.spinics.net/lists/kernel/msg1563777.html
>>
>> Its the DMA engine driver which makes the private DMA calls so this
>> patch is better.
> 
> I would have done 'depends on TI_PRIV_EDMA' instead, but any of the three
> solutions is fine with me.

TI_PRIV_EDMA is not a user selectable option so if 'depends on' is used,
then the select in mach-omap2 is needed as well.

Thanks,
Sekhar
