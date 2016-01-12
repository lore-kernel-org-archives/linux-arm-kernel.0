From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 12 Jan 2016 08:23:02 +0000
Subject: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
In-Reply-To: <CABxcv=mQoDxb7oHh0DdC_t1_m-j=4Hp-sPNoq4Apy4c7CneSng@mail.gmail.com>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
 <CABxcv=mQoDxb7oHh0DdC_t1_m-j=4Hp-sPNoq4Apy4c7CneSng@mail.gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641D63E880D@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Thank you for your review.

> -----Original Message-----
> From: Javier Martinez Canillas [mailto:javier at dowhile0.org]
> Sent: 2016?1?8? 23:00
> To: Yang, Wenyou <Wenyou.Yang@atmel.com>
> Cc: Sebastian Reichel <sre@kernel.org>; Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com>; David Woodhouse <dwmw2@infradead.org>; Rob
> Herring <robh+dt@kernel.org>; Pawel Moll <pawel.moll@arm.com>; Mark
> Rutland <mark.rutland@arm.com>; Ian Campbell <ijc+devicetree@hellion.org.uk>;
> Kumar Gala <galak@codeaurora.org>; Ferre, Nicolas
> <Nicolas.FERRE@atmel.com>; linux-arm-kernel at lists.infradead.org; Linux
> Kernel <linux-kernel@vger.kernel.org>; linux-pm at vger.kernel.org
> Subject: Re: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
> 
> Hello Wenyou,
> 
> On Thu, Jan 7, 2016 at 11:13 PM, Wenyou Yang <wenyou.yang@atmel.com>
> wrote:
> > This patch adds new driver for Active-semi ACT8945A ActivePath charger
> > (part of ACT8945A MFD driver) providing power supply class information
> > to userspace.
> >
> > The driver is configured through DTS (battery and system related
> > settings) and sysfs entries (timers and input over-voltage threshold).
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >
> 
> [snip]
> 
> > +
> > +static struct platform_driver act8945a_charger_driver = {
> > +       .driver = {
> > +               .name = "act8945a-charger",
> > +       },
> > +       .probe  = act8945a_charger_probe,
> > +       .remove = act8945a_charger_remove, };
> > +
> 
> The driver is missing an OF match table (and also a platform ID match table if
> non-DT is supported) so this means that module autoloading will be broken for this
> driver since the platform uevent function will report a MODALIAS=of:N*T*Cactive-
> semi,act8945a-charger

This is an MFD device, it compatible is declared in the ../mfd/act8945a.c file.

	.of_compatible = "active-semi,act8945a-charger".

The non-DT  is not supported in this patch. So a platform ID match table is not included.

> 
> Matching is only working because the platform bus match function use as a
> fallback the driver name.


> 
> Best regards,
> Javier


Best Regards,
Wenyou Yang
