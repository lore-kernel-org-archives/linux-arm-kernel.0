From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 21 Jan 2015 21:46:29 +0100
Subject: [PATCHv5 0/4] USB: gadget: atmel_usba_udc: Driver improvements
In-Reply-To: <1421868674-30757-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421868674-30757-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150121214629.5b1e3e30@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On Wed, 21 Jan 2015 20:31:10 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Start clocks on rising edge of the Vbus signal, stop clocks on falling 
> edge of the Vbus signal.
> 
> Add suspend/resume with wakeup support.

Apart from the minor comment I made on patch 4, you can add my:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

to the whole series.

Thanks for your patience.

Best Regards,

Boris

> 
> Changes since v4:
>   * Now using IRQ_NOAUTOEN flag to remove the unused check for 
>     udc->driver is not NULL in the Vbus IRQ.
>   * Reworked the start/stop of clocks on Vbus edges to prepare for 
>     suspend/resume support, factorised start and stop procedures
>   * New patch, suspend/resume for USBA with wakeup support
> 
> Changes since v3:
>   * Added stable tag for the first patch
>   * As suggested, removed the unused check for udc->driver is not NULL in
>     Vbus IRQ by requesting IRQ after udc->driver is set and by releasing
>     IRQ before udc->driver is cleared
>   * Rebased the core patch of this series against the just explained changes
> 
> Changes since v2:
>   * Use spin_lock_irqsave/unlock_irqrestore instead of spin_lock/unlock in
>     threaded interrupt because we are not in irq context anymore
>   * Removed useless and probably harmful IRQF_NO_SUSPEND from
>     devm_request_threaded_irq() flags
> 
> Changes since v1:
>   * Using a threaded irq and mutex instead of spinclock as suggested
>   * Moved a silently fixed bug in a separate patch (1/2)
> 
> Sylvain Rochet (4):
>   USB: gadget: atmel_usba_udc: Fixed vbus_prev initial state
>   USB: gadget: atmel_usba_udc: Request an auto disabled Vbus signal IRQ
>     instead of an auto enabled IRQ request followed by IRQ disable
>   USB: gadget: atmel_usba_udc: Start clocks on rising edge of the Vbus
>     signal, stop clocks on falling edge of the Vbus signal
>   USB: gadget: atmel_usba_udc: Add suspend/resume with wakeup support
> 
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 214 ++++++++++++++++++++++++--------
>  drivers/usb/gadget/udc/atmel_usba_udc.h |   4 +
>  2 files changed, 165 insertions(+), 53 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
