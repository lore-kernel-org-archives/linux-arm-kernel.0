From: cjb@laptop.org (Chris Ball)
Date: Tue, 26 Nov 2013 17:24:45 -0500
Subject: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when
 using DMA
In-Reply-To: <528E29D0.9080507@atmel.com> (Nicolas Ferre's message of "Thu, 21
 Nov 2013 16:42:08 +0100")
References: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>
 <528E29D0.9080507@atmel.com>
Message-ID: <87zjoqer82.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 21 2013, Nicolas Ferre wrote:
> On 20/11/2013 16:01, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> With some SDIO devices, timeout errors can happen when reading data. To solve
>> this issue the DMA transfer has to be activated before sending the command to
>> the device. This order is incorrect in PDC mode. So we have to take care if we
>> are using DMA or PDC to know when to send the MMC command.
>>
>> Cc: <stable@vger.kernel.org> #3.2+
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
