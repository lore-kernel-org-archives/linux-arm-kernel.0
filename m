From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 26 Jun 2018 22:11:17 +0530
Subject: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
In-Reply-To: <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
 <a261bae6-d2fa-a550-7232-7647ce0ac0e2@suse.de>
Message-ID: <20180626164117.GA5241@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Sun, Jun 24, 2018 at 03:04:21PM +0200, Andreas F?rber wrote:
> Hi Mani,
> 
> Am 11.04.2018 um 18:40 schrieb Manivannan Sadhasivam:
> > Define power domains for Actions Semi S900 SoC Smart Power System (SPS).
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/power/actions,owl-sps.txt  |  2 ++
> >  include/dt-bindings/power/owl-s900-powergate.h     | 23 ++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100644 include/dt-bindings/power/owl-s900-powergate.h
> > 
> > diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > index 78edd63641e8..a3571937b019 100644
> > --- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > +++ b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
> > @@ -3,11 +3,13 @@ Actions Semi Owl Smart Power System (SPS)
> >  Required properties:
> >  - compatible          :  "actions,s500-sps" for S500
> >                           "actions,s700-sps" for S700
> > +                         "actions,s900-sps" for S900
> >  - reg                 :  Offset and length of the register set for the device.
> >  - #power-domain-cells :  Must be 1.
> >                           See macros in:
> >                            include/dt-bindings/power/owl-s500-powergate.h for S500
> >                            include/dt-bindings/power/owl-s700-powergate.h for S700
> > +                          include/dt-bindings/power/owl-s900-powergate.h for S900
> >  
> >  
> >  Example:
> > diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
> > new file mode 100644
> > index 000000000000..f1aaf761112b
> > --- /dev/null
> > +++ b/include/dt-bindings/power/owl-s900-powergate.h
> > @@ -0,0 +1,23 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> checkpatch.pl warns about this line due to not using /* ... */ syntax
> for headers. I could fix that up on my own, but it made me realize that
> you are licensing this file under GPL-2.0+ only, whereas the .dts[i] is
> supposed to be dual-licensed.
> 
> Can you please give your consent to make this
> 
> /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 

You can change the license to GPL-2.0+ OR MIT.

> like my S500 and S700 bindings?
> 
> Question: Should it still be GPL-2.0+ or the new GPL-2.0-or-later?
>

I think GPL-2.0+ is fine.

Thanks,
Mani

> Otherwise looks fine, except that I'll need a topic branch
> (v4.19/s900-sps-bindings) if we want to merge the driver portion at the
> same time.
> 
> Regards,
> Andreas
> 
> > +/*
> > + * Actions Semi S900 SPS
> > + *
> > + * Copyright (c) 2018 Linaro Ltd.
> > + */
> > +#ifndef DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
> > +#define DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
> > +
> > +#define S900_PD_GPU_B	0
> > +#define S900_PD_VCE	1
> > +#define S900_PD_SENSOR	2
> > +#define S900_PD_VDE	3
> > +#define S900_PD_HDE	4
> > +#define S900_PD_USB3	5
> > +#define S900_PD_DDR0	6
> > +#define S900_PD_DDR1	7
> > +#define S900_PD_DE	8
> > +#define S900_PD_NAND	9
> > +#define S900_PD_USB2_H0	10
> > +#define S900_PD_USB2_H1	11
> > +
> > +#endif
> > 
> 
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
