From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Nov 2010 16:53:42 +0100
Subject: Single binary kernel for all i.MX
In-Reply-To: <AANLkTim7znztJgGvZ5ZsV=ei=_W4YpjU3-5zWonrQ9ME@mail.gmail.com>
References: <20101105121800.GV6017@pengutronix.de>
	<AANLkTim7znztJgGvZ5ZsV=ei=_W4YpjU3-5zWonrQ9ME@mail.gmail.com>
Message-ID: <20101112155342.GJ18358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Nov 12, 2010 at 11:40:41PM +0800, Shawn Guo wrote:
> I'm studying at the implementation.  Can you please help me understand
> how "addruart" in plat-mxc/include/mach/debug-macro.S works for single
> image?
> 
>         .macro  addruart, rp, rv
>         ldr     \rp, =UART_PADDR        @ physical
>         ldr     \rv, =UART_VADDR        @ virtual
>         .endm
> 
> We have this macro to get physical base address of UART.  However
> UART_PADDR is defined as MX?_UART1_BASE_ADDR depending on
> CONFIG_ARCH_MX*.  When all CONFIG_ARCH_MX* get defined in single image
> case, how does UART_PADDR work for all CONFIG_ARCH_MX*?
In a kernel that supports more than one SoC, DEBUG_LL won't work.  This
is generally OK, because DEBUG_LL is only needed when bringing up a
machine.  Therefor you can use a tailored kernel that only supports your
shiny new machine.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
