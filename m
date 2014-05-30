From: b32955@freescale.com (Huang Shijie)
Date: Fri, 30 May 2014 17:01:30 +0800
Subject: [PATCH 1/2] serial: imx: remove the DMA wait queue
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EBE14B5A2C@NA-MBX-03.mgc.mentorg.com>
References: <1400819575-20435-1-git-send-email-b32955@freescale.com>
 <857E9EDCA6C0904DB3357321AA9123EBE14B5A2C@NA-MBX-03.mgc.mentorg.com>
Message-ID: <20140530090128.GA4380@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 09:27:20AM +0000, Wang, Jiada (ESD) wrote:
> Hi Shijie
> 
> After apply this patch into our kernel,
> We are facing data hang issue when sending big size file (2M used in test) to uart port
> Note: Rx port is also keep receiving data.
> 
> After read the implementation of uart_stop(),
> I feel like, stop_tx() is used to perform flow control when like a XOFF is received.
> Which means no data should be dropped, as they may need to be sent out,
> When next start_tx() is called.
> 
> But by calling dmaengine_termiate_all(), the data already be submitted to DMA engine,
> May be lost, thus cause data hang.
> 
> What do you think?
This patch has been reverted by Greg.

I also noticed the data loss issue. 

thanks
Huang Shijie
