From: stigge@antcom.de (Roland Stigge)
Date: Sun, 03 Jun 2012 21:49:40 +0200
Subject: [PATCH v4] MTD: LPC32xx SLC NAND driver
In-Reply-To: <20120603190932.GB23368@n2100.arm.linux.org.uk>
References: <1338748689-29645-1-git-send-email-stigge@antcom.de>
 <20120603190932.GB23368@n2100.arm.linux.org.uk>
Message-ID: <4FCBBFD4.9090401@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Thanks for the suggestions!

On 03/06/12 21:09, Russell King - ARM Linux wrote:
>> +	dma_async_issue_pending(host->dma_chan);
>> +
>> +	wait_for_completion_timeout(&host->comp, msecs_to_jiffies(1000));
> 
> What about unmapping the buffer upon completion?

OK - by not specifying DMA_COMPL_SKIP_*_UNMAP in flags, I was thinking
that this happens somehow magically. ;-) But maybe I was just confused.

Thanks,

Roland
