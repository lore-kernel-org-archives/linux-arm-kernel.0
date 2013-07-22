From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jul 2013 12:24:33 +0100
Subject: [PATCH] ARM: debug: use generic option for ep93xx PL10x debug port
In-Reply-To: <201307171048.17430.hartleys@visionengravers.com>
References: <201307171048.17430.hartleys@visionengravers.com>
Message-ID: <20130722112433.GK24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:48:16AM -0700, H Hartley Sweeten wrote:
> The generic option DEBUG_LL_UART_PL01X is now used to select the UART
> type for the kernel low-level debugging on the ep93xx platform. This
> enables two config options to provide the physical and virtual base
> address of the debug UART.
> 
> Use the generic options instead of providing platform specific options
> to select the debug UART.
> 
> UART1 is selected with:  DEBUG_UART_PHYS = 0x808c0000
>                          DEBUG_UART_VIRT = 0xfedc0000
> 
> UART2 is selected with:  DEBUG_UART_PHYS = 0x808d0000
>                          DEBUG_UART_VIRT = 0xfedd0000
> 
> UART3 is selected with:  DEBUG_UART_PHYS = 0x808e0000
>                          DEBUG_UART_VIRT = 0xfede0000
> 
> The selected UART must already be initialized by the bootloader. If it
> isn't setup nothing will appear (which might be desired).
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Ryan Mallon <rmallon@gmail.com>
> ---
> This applies on top of Russell King's "Clean up the debugging support".

Please put this in the patch system; I'll get a round tuit maybe later
this week, if not next week.
