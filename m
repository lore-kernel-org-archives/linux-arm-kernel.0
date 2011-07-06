From: simon@sequanux.org (Simon Guinot)
Date: Wed, 6 Jul 2011 15:31:28 +0000
Subject: [PATCH v2] genirq: replace irq_gc_ack() with {set,clr}_bit
	variants
In-Reply-To: <1309789999-2293-1-git-send-email-simon@sequanux.org>
References: <CAMAG_eexDoKrPsrd7+3bpsN3y0pptqwhFRP2NKqd_Nny+M+NGg@mail.gmail.com>
	<1309789999-2293-1-git-send-email-simon@sequanux.org>
Message-ID: <20110706153128.GA22857@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Jul 04, 2011 at 04:33:19PM +0200, Simon Guinot wrote:
> From: Simon Guinot <sguinot@lacie.com>
> 
> Depending on the device, interrupts acknowledgement is done by setting
> or by clearing a dedicated register. Replace irq_gc_ack() with some
> {set,clr}_bit variants allows to handle both cases.
> 
> Note that this patch affects the following SoCs: Davinci, Samsung and
> Orion. Except for this last, the change is minor: irq_gc_ack() is just
> renamed into irq_gc_ack_set_bit().
> 
> For the Orion SoCs, the edge GPIO interrupts support is currently
> broken. irq_gc_ack() try to acknowledge a such interrupt by setting
> the corresponding cause register bit. The Orion GPIO device expect the
> opposite. To fix this issue, the irq_gc_ack_clr_bit() variant is used.
> 
> Tested on Network Space v2.
> 
> Reported-by: Joey Oravec <joravec@drewtech.com>
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> ---
> Changes for v2: update patch description (mention the affected SoCs).
> 
>  arch/arm/mach-davinci/irq.c      |    2 +-
>  arch/arm/plat-orion/gpio.c       |    2 +-
>  arch/arm/plat-s5p/irq-gpioint.c  |    2 +-
>  arch/arm/plat-samsung/irq-uart.c |    2 +-
>  include/linux/irq.h              |    3 ++-
>  kernel/irq/generic-chip.c        |   18 ++++++++++++++++--
>  6 files changed, 22 insertions(+), 7 deletions(-)

Please, apply this patch.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110706/dd8a0d68/attachment.sig>
