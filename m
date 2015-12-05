From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sat, 5 Dec 2015 13:49:21 -0800
Subject: [PATCH LINUX v3 08/10] tty: xuartps: Move RX path into helper
 function
In-Reply-To: <56632177.1090605@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-9-git-send-email-soren.brinkmann@xilinx.com>
 <56632177.1090605@hurleysoftware.com>
Message-ID: <20151205214921.GN4900@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-12-05 at 12:40PM -0500, Peter Hurley wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> > Move RX-related IRQ handling into a helper function.
> Fixes a problem where every char received after a parity or frame error
> in the current isr will also be tagged as a parity or frame error.
> 
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

Thanks. I'll add your text to the commit message.

> 
> NB: the sysrq problem in cdns_uart_isr() with needing to drop the
> locks is because cdns_uart_console_write() tries to take the port->lock.
> The 8250 driver handles this problem by not trying to take the
> port->lock if port->sysrq is non-zero. See serial8250_console_write().

I'll look into this. I'll see if I can include that in the next
iteration of this series or do it later.

	Thanks,
	S?ren
