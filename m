From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 20 Oct 2016 19:34:15 +0200
Subject: [PATCH] Revert "dmaengine: pxa_dma: add support for legacy
 transition"
In-Reply-To: <8371252.IL4ByDpZCD@wuerfel> (Arnd Bergmann's message of "Tue, 18
 Oct 2016 10:57:14 +0200")
References: <1476773192-23715-1-git-send-email-robert.jarzmik@free.fr>
 <8371252.IL4ByDpZCD@wuerfel>
Message-ID: <87mvhy3ox4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday, October 18, 2016 8:46:32 AM CEST Robert Jarzmik wrote:
>> This reverts commit c91134d9194478144ba579ca6efeddf628055650.
>> 
>> The conversion of the pxa architecture is now finished for all
>> drivers, so this functions has fullfilled its purpose and can
>> now be removed.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> Nice!
>
> That reminds me, do you have plans to work on the conversion away from
> IORESOURCE_DMA and pxad_filter_fn towards the dma_slave_map interface?
>
> I see that all pxa drivers already use dma_request_slave_channel_compat,
> so this should be fairly straightforward to do, changing only the
> driver and the arch/arm/mach-pxa/devices.c file.

I didn't so far, as I wasn't aware of this interface, but I'll gladly put that
on my todo list.

Cheers.

-- 
Robert
