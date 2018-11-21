From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 21 Nov 2018 09:51:41 +0100
Subject: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate
 resources
In-Reply-To: <b30f6b76-52c1-89ca-dbf3-a4156d1fb55e@ti.com>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-2-brgl@bgdev.pl>
 <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
 <63ac671f-b202-2533-3878-af16149fbdbb@ti.com>
 <b30f6b76-52c1-89ca-dbf3-a4156d1fb55e@ti.com>
Message-ID: <CAMpxmJV8rEC5s4Mi-_3g_V1oojt_WpiRkB1RrCCYJGF+fiwYLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?r., 21 lis 2018 o 00:07 Sekhar Nori <nsekhar@ti.com> napisa?(a):
>
> On 20/11/18 12:08 PM, J, KEERTHY wrote:
> >
> >
> > On 11/20/2018 2:22 AM, Sekhar Nori wrote:
> >> On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
> >>> IRQ numbering") the davinci GPIO driver fails to probe if we boot
> >>> in legacy mode from any of the board files. Since the driver now
> >>> expects every interrupt to be defined as a separate resource, split
> >>> the definition in devices-da8xx.c instead of having a single continuous
> >>> interrupt range.
> >>>
> >>> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ
> >>> numbering")
> >>> Cc: stable at vger.kernel.org
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> There are a number of other boards that need such fixing too. And the
> >> commit in question does not do a good job of explaining why it was
> >> needed in the first place. The description  just repeats what can be
> >> inferred by reading the patch.
> >
> > Cc Lokesh
> >
> > Sekhar,
> >
> > DT explicitly mentions every IRQ number. The patch in discussion
> > explicitly calls platform_get_irq for all the interrupts which to me is
> > the right thing to do as: platform_get_irq-->
> > of_irq_get-->irq_create_of_mapping--> sequence is to be done for every IRQ.
> >
> > k3-am654 definitely will need explicit calls to platform_get_irq as it
> > will be involving interrupt router and interrupt numbers need not be
> > continuous.
> >
> > So i do not think reverting the patch is the right idea.
>
> Well, all of this description of patch motivation should have been in
> the patch description to begin with.
>
> Bartosz, can you please extend this patch to fix this problem for other
> DaVinci SoCs too? I am on the road this week, but will do my best to
> queue these fixes at the earliest .
>
> Thanks,
> Sekhar

Ok, to make it easier for you, I'll resend all the patches addressing
the GPIO issue.

Bart
