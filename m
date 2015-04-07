From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Tue, 7 Apr 2015 12:46:46 +0000
Subject: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307566598FD3@IN01WEMBXB.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 April 2015 11:55 PM, Joe Perches wrote:

These structs can be const, so make them const.

Miscellanea:

o Add static to struct uart_ops declaration in bfin_sport_uart

Signed-off-by: Joe Perches <joe@perches.com><mailto:joe@perches.com>
---
On Sun, 2015-04-05 at 00:04 +0200, Stefan Agner wrote:


> On 2015-04-04 19:47, Joe Perches wrote:


> > Done with:
> > sed -r -i -e 's/\bstruct\s+uart_ops\s+(\w+)\s*=\s*/const struct
> > uart_ops \1 = /g' drivers/tty/serial/*.c


[]


> +++ b/drivers/tty/serial/fsl_lpuart.c
> Something went wrong in this driver, const is twice...


Apologies, thanks for noticing.
The sed was mistakenly done twice on that file.

V2:

o Fix duplicate const in fsl_lpuart.c
o Add static to drivers/tty/serial/bfin_sport_uart.c

Still compiled only x86 and not cross-compiled or tested.

 drivers/tty/serial/21285.c                  | 2 +-
 drivers/tty/serial/altera_jtaguart.c        | 2 +-
 drivers/tty/serial/altera_uart.c            | 2 +-
 drivers/tty/serial/amba-pl010.c             | 2 +-
 drivers/tty/serial/amba-pl011.c             | 2 +-
 drivers/tty/serial/apbuart.c                | 2 +-
 drivers/tty/serial/ar933x_uart.c            | 2 +-
 drivers/tty/serial/arc_uart.c               | 2 +-

Acked-by: Vineet Gupta <vgupta@synopsys.com><mailto:vgupta@synopsys.com> # for arc_uart

Th,
-Vineet
