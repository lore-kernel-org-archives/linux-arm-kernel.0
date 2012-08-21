From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 21 Aug 2012 16:13:59 +0530
Subject: [RFC/PATCH 00/13] OMAP UART patches
In-Reply-To: <1345540555-24359-1-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gxJqpJG0LbhbJ-YKOEpR=2_ogu2SpdUtvafn2kBXWudyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi guys,
>
> here's a series of cleanup patches to the OMAP serial
> driver. A later series could be made re-implementing
> DMA using the DMA Engine API. Note that for RX DMA
> we could be using RX Timeout IRQ as a hint that we better
> use PIO instead ;-)
>
> All patches were tested on my pandaboard, but I'd really
> like to receive Tested-by on other platforms.
>
> After this goes in, I'll probably try to get UART wakeup
> working again and only after that look at DMA.
>
> cheers
>
> Felipe Balbi (13):
>   serial: omap: define and use to_uart_omap_port()
>   serial: omap: always return IRQ_HANDLED
>   serial: omap: define helpers for pdata function pointers
>   serial: omap: don't access the platform_device
>   serial: omap: drop DMA support
>   serial: add OMAP-specific defines
>   serial: omap: simplify IRQ handling
>   serial: omap: refactor receive_chars() into rdi/rlsi handlers
>   serial: omap: move THRE check to transmit_chars()
>   serial: omap: stick to put_autosuspend
>   serial: omap: set dev->drvdata before enabling pm_runtime
>   serial: omap: drop unnecessary check from remove
>   serial: omap: make sure to suspend device before remove
>
Apart from that one question on last patch, rest of the clean-up
is really good. Nice work.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
