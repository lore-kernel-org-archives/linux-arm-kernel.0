From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 May 2014 14:30:50 +0800
Subject: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
In-Reply-To: <53706014.8010203@de.bosch.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
 <537042B5.2040600@freescale.com> <53706014.8010203@de.bosch.com>
Message-ID: <53706A9A.6060707@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?05?12? 13:45, Dirk Behme ??:
> On 12.05.2014 05:40, Huang Shijie wrote:
>> ? 2014?05?09? 23:19, dean_jenkins at mentor.com ??:
>>> Use imx_start_tx() just to enable the TX interrupt. It's the job of the
>>> TX interrupt ISR to fill the transmit buffer, then. If the transmit 
>>> buffer
 From the Documentation/serial/driver, we can see:
   -----------------------------------------
    start_tx(port)
     Start transmitting characters.
    -----------------------------------------

It tells us we can transmit data in the imx_start_tx.

But this patch moves it to the interrupt handler, this patch makes the 
interrupt handler do more jobs.




>>> is empty, the TX interrupt should be executed as soon as the start_tx()
>>> enables the interrupt, so there is no reason for the extra
>>> imx_transmit_buffer() call, here. Remove it.
>> I don't know why this patch needed?
>> What problem this patch fix or improve?
>
> As stated in the commit message, the call of imx_transmit_buffer() 
> isn't needed there, so it can be removed. I.e. remove unneeded code.

>
> In the end, this cleans up the possible locking path, so that in the 
> third patch the locking issue can be easily fixed.
>
The lock issue had been fixed already. Please try the latest linux-next.
see my comment in the third patch.


thanks
Huang Shijie
