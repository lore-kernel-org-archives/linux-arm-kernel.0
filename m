From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Aug 2012 13:40:47 +0300
Subject: [PATCH v3 00/23] OMAP UART patches
In-Reply-To: <1345717983-18179-1-git-send-email-balbi@ti.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
Message-ID: <20120824104045.GC5172@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot to Cc greg initially, my bad

On Thu, Aug 23, 2012 at 01:32:40PM +0300, Felipe Balbi wrote:
> Hi guys,
> 
> here's v3 and hopefully final version of this series. A whole bunch of new
> patches added but the good thing is that now I had another engineer's help to
> test, so he's got his Tested-by in all patches.
> 
> Changes since v2:
> 	. Added a bunch of new patches
> 	. Fixed a problem where we would always return IRQ_NONE even though we
> 		handled IRQ
> 
> Changes since v1:
>         . improved commit log on patch 9/13 (formerly 10/13)
>         . removed patch 2/13
>         . added a new patch switching from spin_lock_irqsave() to spin_lock and
>                 spin_unlock_irqrestore to spin_unlock
> 
> Alan, if you prefer in pull request form, here it is:
> 
> The following changes since commit d9875690d9b89a866022ff49e3fcea892345ad92:
> 
>   Linux 3.6-rc2 (2012-08-16 14:51:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git uart
> 
> for you to fetch changes up to a29230f14d8466c9b8c25171715378bf52189453:
> 
>   serial: omap: enable RX and TX FIFO usage (2012-08-23 09:25:16 +0300)
> 
> ----------------------------------------------------------------
> Felipe Balbi (20):
>       serial: omap: define and use to_uart_omap_port()
>       serial: omap: define helpers for pdata function pointers
>       serial: omap: don't access the platform_device
>       serial: omap: drop DMA support
>       serial: add OMAP-specific defines
>       serial: omap: simplify IRQ handling
>       serial: omap: refactor receive_chars() into rdi/rlsi handlers
>       serial: omap: move THRE check to transmit_chars()
>       serial: omap: stick to put_autosuspend
>       serial: omap: set dev->drvdata before enabling pm_runtime
>       serial: omap: drop unnecessary check from remove
>       serial: omap: make sure to suspend device before remove
>       serial: omap: don't save IRQ flags on hardirq
>       serial: omap: optimization with section annotations
>       serial: omap: drop "inline" from IRQ handler prototype
>       serial: omap: implement set_wake
>       serial: omap: make sure to put() on poll_get_char
>       serial: omap: remove unnecessary header and add a missing one
>       serial: omap: move uart_omap_port definition to C file
>       serial: omap: enable RX and TX FIFO usage
> 
> Ruchika Kharwar (2):
>       serial: omap: fix sequence of pm_runtime_* calls.
>       serial: omap: unlock the port lock
> 
> Vikram Pandita (1):
>       serial: omap: fix software flow control
> 
>  arch/arm/mach-omap2/serial.c                  |  15 +-
>  arch/arm/plat-omap/include/plat/omap-serial.h |  47 +-
>  drivers/tty/serial/omap-serial.c              | 808 ++++++++++----------------
>  include/linux/serial_reg.h                    |   4 +
>  4 files changed, 330 insertions(+), 544 deletions(-)
> 
> -- 
> 1.7.12.rc3
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120824/848da8b1/attachment.sig>
