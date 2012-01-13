From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 12 Jan 2012 18:20:37 -0700
Subject: [PATCH 0/2] Full DT IRQ support for versatile
In-Reply-To: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
Message-ID: <CACxGe6v-gkW+pDP-2hTcf7WqeMBtx+H80Xymj7SqS8nqin9qUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 5:43 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> These patches move versatile over to instantiating both interrupt
> controllers from the device tree. ?I've tested this in qemu for both DT
> and non-DT platforms but only with an initramfs. ?I've seen interrupts
> generated on both controllers for both boot methods.
>
> Grant, Rob, this makes use of irqdomain again as I'm not sure what the
> replacement is going to look like yet. ?versatile works with DT in
> mainline, but that's kind of lucky... ?I know there's been patches to
> make irq_domain_add_simple() return the irq_domain and can rebase if
> needed.

I posted the patches for finishing up irq_domain migration yesterday.
irq_domain_add_simple() can trivially be changed to
irq_domain_add_legacy. I'll try out these
patches on top of my irqdomain/next branch

g.

>
> Jamie Iles (2):
> ?versatile: sic: add device tree bindings
> ?versatile: dt: register interrupt controllers from dt
>
> ?.../devicetree/bindings/arm/versatile-sic.txt ? ? ?| ? 27 ++++++++++
> ?arch/arm/mach-versatile/core.c ? ? ? ? ? ? ? ? ? ? | ? 27 +++-------
> ?arch/arm/mach-versatile/core.h ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-versatile/versatile_dt.c ? ? ? ? ? ? | ? 15 +++++-
> ?arch/arm/plat-versatile/Kconfig ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-versatile/fpga-irq.c ? ? ? ? ? ? ? ? | ? 51 +++++++++++++++++++-
> ?arch/arm/plat-versatile/include/plat/fpga-irq.h ? ?| ? ?6 ++
> ?7 files changed, 106 insertions(+), 22 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/versatile-sic.txt
>
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
