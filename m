From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 5 Mar 2015 09:34:46 +0000
Subject: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
 driver support
In-Reply-To: <1425333669.24292.124.camel@x220>
References: <6f3b34935c0f405199cacd5312e972ac@BN1BFFO11FD017.protection.gbl>
 <1425333669.24292.124.camel@x220>
Message-ID: <d4deaffbdf1e47749400a557e9918bbd@BN1BFFO11FD029.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul Bolle,

Thanks for reviewing the patch

> -----Original Message-----
> From: Paul Bolle [mailto:pebolle at tiscali.nl]
> Sent: Tuesday, March 03, 2015 3:31 AM
> To: Appana Durga Kedareswara Rao
> Cc: dan.j.williams at intel.com; vinod.koul at intel.com; Michal Simek; Soren
> Brinkmann; dmaengine at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Appana Durga
> Kedareswara Rao; Anirudha Sarangi; Srikanth Vemula; Srikanth Thokala
> Subject: Re: [PATCH v5] dma: Add Xilinx AXI Direct Memory Access Engine
> driver support
>
> On Mon, 2015-03-02 at 23:25 +0530, Kedareswara rao Appana wrote:
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -425,6 +425,19 @@ config IMG_MDC_DMA
> >     help
> >       Enable support for the IMG multi-threaded DMA controller (MDC).
> >
> > +config XILINX_DMA
> > +   tristate "Xilinx AXI DMA Engine"
> > +   depends on (ARCH_ZYNQ || MICROBLAZE)
> > +   select DMA_ENGINE
> > +   help
> > +     Enable support for Xilinx AXI DMA Soft IP.
> > +
> > +   This engine provides high-bandwidth direct memory access
> > +   between memory and AXI4-Stream type target peripherals.
> > +   It has two stream interfaces/channels, Memory Mapped to
> > +   Stream (MM2S) and Stream to Memory Mapped (S2MM) for the
> > +   data transfers.
> > +
>
> How did you test this patch? On next-20150302, running x86_64, I got:
>
> $ make ARCH=microblaze menuconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/mconf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTCC  scripts/kconfig/lxdialog/checklist.o
>   HOSTCC  scripts/kconfig/lxdialog/util.o
>   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>   HOSTCC  scripts/kconfig/lxdialog/textbox.o
>   HOSTCC  scripts/kconfig/lxdialog/yesno.o
>   HOSTCC  scripts/kconfig/lxdialog/menubox.o
>   HOSTLD  scripts/kconfig/mconf
> scripts/kconfig/mconf Kconfig
> drivers/dma/Kconfig:436: syntax error
> drivers/dma/Kconfig:435: unknown option "This"
> drivers/dma/Kconfig:436: unknown option "between"
> drivers/dma/Kconfig:437: unknown option "It"
> drivers/dma/Kconfig:438: unknown option "Stream"
> drivers/dma/Kconfig:439: unknown option "data"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2
>
> Caused by the invalid indentation used here. You should add two spaces
> after the initial tab in lines 436 through 439.
>

My Bad I forgot to compile the patch before I sent to the open source.
Will fix this in the next version of the patch.

Regards,
Kedar.

>
> Paul Bolle



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
