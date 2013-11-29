From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Nov 2013 17:44:06 +0100
Subject: [PATCH 0/3] serial: mxs-auart: flush_buffer hook and interrupt
 processing
In-Reply-To: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
Message-ID: <201311291744.06943.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hector,

> Hello,
> 
> This series implement several fixes to the mxs-auart serial driver.
> 
> The first patch implements the flush_buffer hook. Currently the driver
> can be shut down and pending data in the FIFO will be lost.
> 
> The second patchs adds a check of the BUSY flag in the tx_empty hook
> to make sure the UART is not about to fill data into the FIFO.
> 
> The third patch moves the interrupt handling from the ISR out to a
> tasklet. This was motivated due to different transmission problems
> with hardware and software flow control at high baudrates whereby
> transmission was interrupted or data lost.
> The problem can be reproduced by setting two AUARTs at 576000/N/8
> with CRTSCTS and sending a large file from one port to the other
>  with 'cat'.

57600 is not that high of a baudrate. Or do you really mean 576000 (576 
thousand) ?

Best regards,
Marek Vasut
