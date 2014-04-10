From: chanho61.park@samsung.com (Chanho Park)
Date: Thu, 10 Apr 2014 19:37:12 +0900
Subject: [PATCH 07/27] irqchip: Declare cortex-a7's irqchip to initialize
 gic from dt
In-Reply-To: <878urd33g4.fsf@approximate.cambridge.arm.com>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-8-git-send-email-cw00.choi@samsung.com>
 <878urd33g4.fsf@approximate.cambridge.arm.com>
Message-ID: <002e01cf54a8$d59897e0$80c9c7a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Marc Zyngier
> Sent: Thursday, April 10, 2014 7:05 PM
> To: Chanwoo Choi
> Cc: mark.rutland at arm.com; linux-samsung-soc at vger.kernel.org;
> t.figa at samsung.com; hyunhee.kim at samsung.com; sw0312.kim at samsung.com;
> linux-kernel at vger.kernel.org; yj44.cho at samsung.com; inki.dae at samsung.com;
> kyungmin.park at samsung.com; kgene.kim at samsung.com; Thomas Gleixner;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 07/27] irqchip: Declare cortex-a7's irqchip to
> initialize gic from dt
> 
> On Thu, Apr 10 2014 at 10:28:24 am BST, Chanwoo Choi
> <cw00.choi@samsung.com> wrote:
> > This patch declare coretex-a7's irqchip to initialze gic from dt
> > with "arm,cortex-a7-gic" data.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/irqchip/irq-gic.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index 4300b66..8e906e4 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -1069,6 +1069,7 @@ gic_of_init(struct device_node *node, struct
> device_node *parent)
> >  }
> >  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
> >  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> > +IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
> >  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
> >  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
> 
> Frankly, this patch adds no value. Are we going to add
> "arm,cortex-a12-gic", "arm,cortex-a17-gic", "arm,cortex-a53-gic",
> "arm,cortex-a57-gic"? And that's just to mention the ARM Ltd cores...
> 
> Instead, how about defining a generic "arm,gic" property, and mandate
> that new DT files are using that? We can always use a more precise
> compatible for quirks.

I prefer it would be arm,gicv2 instead arm-gic.
In case of GICv3 of arm64, it can be arm,gicv3.

Best Regards,
Chanho Park
