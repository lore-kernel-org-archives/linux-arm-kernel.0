From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 May 2014 14:53:12 +0800
Subject: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
In-Reply-To: <53706CC3.4030907@de.bosch.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com>
 <53706A9A.6060707@freescale.com> <53706CC3.4030907@de.bosch.com>
Message-ID: <53706FD8.6090201@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?05?12? 14:40, Dirk Behme ??:
> On 12.05.2014 08:30, Huang Shijie wrote:
>> ? 2014?05?12? 13:45, Dirk Behme ??:
>>> On 12.05.2014 05:40, Huang Shijie wrote:
>>>> ? 2014?05?09? 23:19, dean_jenkins at mentor.com ??:
>>>>> Use imx_start_tx() just to enable the TX interrupt. It's the job 
>>>>> of the
>>>>> TX interrupt ISR to fill the transmit buffer, then. If the transmit
>>>>> buffer
>>   From the Documentation/serial/driver, we can see:
>>     -----------------------------------------
>>      start_tx(port)
>>       Start transmitting characters.
>>      -----------------------------------------
>>
>> It tells us we can transmit data in the imx_start_tx.
>
> Well, it depends how you read 'Start transmitting', no?
>
> It doesn't have to mean 'actually transmit data'. It talks about 
> 'start'. And this could also mean 'start the transmission (by enabling 
> the interrupt)'.
>
Ok :)
I do not object this patch.

My opinion is : If the third patch is redundant, could this patch still 
needed?


>> But this patch moves it to the interrupt handler,
>
> It doesn't 'move' any code to the interrupt handler. The code in the 
> interrupt handler is already there.
>
i knew it.

>> this patch makes the
>> interrupt handler do more jobs.
>
> ... to get the locking in the correct order.
>
again, the third patch can be ignored.
The locking is correct for the imx.c.


thanks
Huang Shijie
