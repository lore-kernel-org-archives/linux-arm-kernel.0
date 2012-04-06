From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 6 Apr 2012 18:19:54 +0200
Subject: [PATCH RFC] ARM: at91: remove at91_register_uart_fns and headers
In-Reply-To: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
References: <1333728149-32711-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <CAGhQ9Vw8vGFkQHzpr4=hbALMVEYn91FG4LDv_4GW11o2L0cubQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 6, 2012 at 6:02 PM, Joachim Eastwood <manabian@gmail.com> wrote:
> No AT91/AVR32 boards currently use at91_register_uart_fns so let's remove it.
>
> The only other mach in the kernel that has a *_register_uart_fns function
> is SA1100 so the demand for this functionality is not great.
>
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>
> ---
> ?arch/arm/include/asm/mach/serial_at91.h ? | ? 33 -----------------------------
> ?arch/avr32/include/asm/mach/serial_at91.h | ? 33 -----------------------------
> ?drivers/tty/serial/atmel_serial.c ? ? ? ? | ? 18 ----------------
> ?3 files changed, 84 deletions(-)
> ?delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
> ?delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h

I forgot to remove the atmel_open_hook/atmel_close_hook from the
driver. (This shaves off another 22 lines)
If nobody objects to the removal of at91_register_uart_fns I'll send
an updated patch.

regards
Joachim Eastwood
