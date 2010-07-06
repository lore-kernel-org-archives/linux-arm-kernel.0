From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Jul 2010 12:12:37 +0900
Subject: [PATCH] ARM: S5P: Add PMU device
In-Reply-To: <AANLkTik3WGvkUsvKHllgSlj9fJJy90y7L4me4tywCoE0@mail.gmail.com>
References: <1278294411-5104-1-git-send-email-jy0922.shim@samsung.com>
	<4C31C47C.1050905@gmail.com>
	<006c01cb1c41$a0af5c10$e20e1430$%kim@samsung.com>
	<AANLkTik3WGvkUsvKHllgSlj9fJJy90y7L4me4tywCoE0@mail.gmail.com>
Message-ID: <009f01cb1cb9$188332d0$49899870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Mon, Jul 5, 2010 at 9:57 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Maurus Cuelenaere wrote:
> >>
> >> ?Op 05-07-10 03:46, Joonyoung Shim schreef:
> >> > This patch adds an initcall for the s5p platforms so that they
register
> >> > their PMU IRQs with the PMU framework in the Kernel.
> >> >
> >> > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> >> > ---
> >> > ?arch/arm/mach-s5p6442/include/mach/irqs.h | ? ?2 +-
> >> > ?arch/arm/mach-s5pc100/include/mach/irqs.h | ? ?1 +
> >> > ?arch/arm/mach-s5pv210/include/mach/irqs.h | ? ?1 +
> >> > ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
> >> > ?arch/arm/plat-s5p/dev-pmu.c ? ? ? ? ? ? ? | ? 37
> >> +++++++++++++++++++++++++++++
> >> > ?5 files changed, 41 insertions(+), 1 deletions(-)
> >> > ?create mode 100644 arch/arm/plat-s5p/dev-pmu.c
> >>
> >> Wouldn't it be better if this was in plat-samsung? I can see that the
S3C6410
> >> datasheet mentions a PMU_IRQ_ENABLE bit in SYS_OTHERS so I suspect
> that it
> >> has
> >> the same functionality (even though there's no mention of which
interrupt this
> >> is).
> >>
> > Yes, I also found PMU_IRQ_ENABLE bit in System Others register of
S3C6410
> datasheet. But as your comments, could not found the interrupt number and
any
> description...Actually, need to check whether it's available or not.
> >
> > And S5P6440 has it.
> > So Joonyoung, it would be helpful if you could add 6440 PMUIRQ
(VIC1[23]) in
> this patch.
> 
> It's another story. Can you explain the difference between 6440 and 6442?
> As I heard it's same chip and type is difference. If true, how about
> to delete the 6442 directory?
> It makes a single kernel simple.
> 

I remember, already explained about that.
Hmm..Where did you hear wrong information that they are same? :-(
Absolutely, they are different !! not same chip.
...

But actually, I'm working on merge some S5P SoCs...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
