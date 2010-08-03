From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 03 Aug 2010 11:33:14 +0900
Subject: [PATCH v4 3/8] ARM: Samsung: Add platform definitions and helpers
	for FIMC driver
In-Reply-To: <AANLkTimTVmrFTWrFH5gSnutSDhckU6akYtFwsARgJnK4@mail.gmail.com>
References: <1279902083-21250-4-git-send-email-s.nawrocki@samsung.com>
	<1280750229-15732-1-git-send-email-m.szyprowski@samsung.com>
	<00e101cb329e$a50ceb60$ef26c220$%kim@samsung.com>
	<AANLkTimJcQccG-H_661bPSz-sQ+L=GYNLd2A3W02wUUP@mail.gmail.com>
	<00e501cb32a5$5775ed50$0661c7f0$%kim@samsung.com>
	<AANLkTinuDaOKe1cMTCC+kmZg0dg2y75szDPQaa93gWbn@mail.gmail.com>
	<00e801cb32a7$fffae0f0$fff0a2d0$%kim@samsung.com>
	<AANLkTimTVmrFTWrFH5gSnutSDhckU6akYtFwsARgJnK4@mail.gmail.com>
Message-ID: <00eb01cb32b4$3c1285a0$b43790e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On Tue, Aug 3, 2010 at 10:05 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Kyungmin Park wrote:
> >>
> >> On Tue, Aug 3, 2010 at 9:46 AM, Kukjin Kim <kgene.kim@samsung.com>
wrote:
> >> > Kyungmin Park wrote:
> >> >>
> >> >> On Tue, Aug 3, 2010 at 8:58 AM, Kukjin Kim <kgene.kim@samsung.com>
> > wrote:
> >> >> > Marek Szyprowski wrote:
> >> >> >>
> >> >> >> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> >> >>
> >> >> >> FIMC (CAMIF) device is a camera interface embedded in S3C/S5P
> > Samsung
> >> >> >> SOC series. It supports ITU-R BT.601/656 and MIPI-CSI2 standards,
> >> >> >> memory to memory operations, color conversion, resizing and
> > rotation.
> >> >> >>
> >> >> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> >> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> >> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> >> >> ---
> >> >> >>
> >> >> >> This is patch is a v3 version rebased onto latest kgene/for-next
> > tree.
> >> >> >> New entries in map.h files has been sorted by the physicall
address.
> >> >> >>
> >> >> > Thanks for your addressing.
> >> >> >
> >> >> >> I'm resending this patch on behalf of Sylwester who is on
holidays
> > this
> >> >> >> week.
> >> >> >>
> >> >> >> Best regards
> >> >> >> --
> >> >> >> Marek Szyprowski
> >> >> >> Samsung Poland R&D Center
> >> >> >> ---
> >
> > (snip)
> >
> >> >> >>
> >> >> >> diff --git a/arch/arm/mach-s5pc100/include/mach/map.h
> > b/arch/arm/mach-
> >> >> >> s5pc100/include/mach/map.h
> >> >> >> index c018697..3abe7f5 100644
> >> >> >> --- a/arch/arm/mach-s5pc100/include/mach/map.h
> >> >> >> +++ b/arch/arm/mach-s5pc100/include/mach/map.h
> >> >> >> @@ -99,6 +99,10 @@
> >> >> >>
> >> >> >> ?#define S5PC100_PA_FB ? ? ? ? ? ? ? ?(0xEE000000)
> >> >> >>
> >> >> >> +#define S5PC100_PA_FIMC0 ? ? (0xEE200000)
> >> >> >> +#define S5PC100_PA_FIMC1 ? ? (0xEE300000)
> >> >> >> +#define S5PC100_PA_FIMC2 ? ? (0xEE400000)
> >> >> >> +
> >> >> >> ?#define S5PC100_PA_I2S0 ? ? ? ? ? ? ?(0xF2000000)
> >> >> >> ?#define S5PC100_PA_I2S1 ? ? ? ? ? ? ?(0xF2100000)
> >> >> >> ?#define S5PC100_PA_I2S2 ? ? ? ? ? ? ?(0xF2200000)
> >> >> >> @@ -143,6 +147,9 @@
> >> >> >> ?#define S3C_PA_ONENAND_BUF ? S5PC100_PA_ONENAND_BUF
> >> >> >> ?#define S3C_SZ_ONENAND_BUF ? S5PC100_SZ_ONENAND_BUF
> >> >> >> ?#define S3C_PA_RTC ? ? ? ? ? S5PC100_PA_RTC
> >> >> >> +#define S5P_PA_FIMC0 ? ? ? ? S5PC100_PA_FIMC0
> >> >> >> +#define S5P_PA_FIMC1 ? ? ? ? S5PC100_PA_FIMC1
> >> >> >> +#define S5P_PA_FIMC2 ? ? ? ? S5PC100_PA_FIMC2
> >> >> >>
> >> >> >> ?#define SAMSUNG_PA_ADC ? ? ? ? ? ? ? S5PC100_PA_TSADC
> >> >> >> ?#define SAMSUNG_PA_CFCON ? ? S5PC100_PA_CFCON
> >> >> >> diff --git a/arch/arm/mach-s5pv210/cpu.c
> > b/arch/arm/mach-s5pv210/cpu.c
> >
> > (snip)
> >
> >> >> >> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h
> > b/arch/arm/mach-
> >> >> >> s5pv210/include/mach/map.h
> >> >> >> index 986b285..6a07e55 100644
> >> >> >> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> >> >> >> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> >> >> >> @@ -65,6 +65,10 @@
> >> >> >>
> >> >> >> ?#define S5PV210_PA_FB ? ? ? ? ? ? ? ?(0xF8000000)
> >> >> >>
> >> >> >> +#define S5PV210_PA_FIMC0 ? ? (0xFB200000)
> >> >> >> +#define S5PV210_PA_FIMC1 ? ? (0xFB300000)
> >> >> >> +#define S5PV210_PA_FIMC2 ? ? (0xFB400000)
> >> >> >> +
> >> >> >> ?#define S5PV210_PA_HSMMC(x) ?(0xEB000000 + ((x) * 0x100000))
> >> >> >>
> >> >> >> ?#define S5PV210_PA_VIC0 ? ? ? ? ? ? ?(0xF2000000)
> >> >> >> @@ -114,4 +118,8 @@
> >> >> >> ?#define SAMSUNG_PA_CFCON ? ? S5PV210_PA_CFCON
> >> >> >> ?#define SAMSUNG_PA_KEYPAD ? ?S5PV210_PA_KEYPAD
> >> >> >>
> >> >> >> +#define S5P_PA_FIMC0 ? ? ? ? S5PV210_PA_FIMC0
> >> >> >> +#define S5P_PA_FIMC1 ? ? ? ? S5PV210_PA_FIMC1
> >> >> >> +#define S5P_PA_FIMC2 ? ? ? ? S5PV210_PA_FIMC2
> >> >> >
> >> >> > To use one style is better for reading, merge conflict handling
and
> > so
> >> > on...
> >> >> > The style means to add S5P_PA_XXX after S3C_PA_XXX with C100 case
> or
> >> to
> >> >> > modify above C100 case like this.
> >> >>
> >> >> Use the same conversion as previous one. are you okay?
> >> >>
> >> >> #define S5PV210_PA_VIC0 ? ? ? ? (0xF2000000)
> >> >> #define S5P_PA_VIC0 ? ? ? ? ? ? S5PV210_PA_VIC0
> >> >>
> >> >> #define S5PV210_PA_VIC1 ? ? ? ? (0xF2100000)
> >> >> #define S5P_PA_VIC1 ? ? ? ? ? ? S5PV210_PA_VIC1
> >> >>
> >> >> #define S5PV210_PA_VIC2 ? ? ? ? (0xF2200000)
> >> >> #define S5P_PA_VIC2 ? ? ? ? ? ? S5PV210_PA_VIC2
> >> >>
> >> >> #define S5PV210_PA_VIC3 ? ? ? ? (0xF2300000)
> >> >> #define S5P_PA_VIC3 ? ? ? ? ? ? S5PV210_PA_VIC3
> >> >>
> >> >> #define S5PV210_PA_SDRAM ? ? ? ?(0x30000000)
> >> >> #define S5P_PA_SDRAM ? ? ? ? ? ?S5PV210_PA_SDRAM
> >> >>
> >> > No.
> >> >
> >> > Did you see above C100?
> >> >
> >> > --- C100
> >> >
> >> > ?#define
> S3C_PA_ONENAND_BUF ? ? ? ? ? ? S5PC100_PA_ONENAND_BUF
> >> > ?#define
> S3C_SZ_ONENAND_BUF ? ? ? ? ? ? S5PC100_SZ_ONENAND_BUF
> >> > ?#define S3C_PA_RTC ? ? ? ? ? ? S5PC100_PA_RTC
> >> > +#define S5P_PA_FIMC0 ? ? ? ? ? S5PC100_PA_FIMC0
> >> > +#define S5P_PA_FIMC1 ? ? ? ? ? S5PC100_PA_FIMC1
> >> > +#define S5P_PA_FIMC2 ? ? ? ? ? S5PC100_PA_FIMC2
> >> >
> >> > ?#define SAMSUNG_PA_ADC ? ? ? ? ? ? ? S5PC100_PA_TSADC
> >> > ?#define SAMSUNG_PA_CFCON ? ? S5PC100_PA_CFCON
> >> >
> >> > --- V210
> >> >
> >> > ?#define SAMSUNG_PA_CFCON ? ? ? ? ? ? ? S5PV210_PA_CFCON
> >> > ?#define SAMSUNG_PA_KEYPAD ? ? ? ? ? ? ?S5PV210_PA_KEYPAD
> >> >
> >> > +#define S5P_PA_FIMC0 ? ? ? ? ? S5PV210_PA_FIMC0
> >> > +#define S5P_PA_FIMC1 ? ? ? ? ? S5PV210_PA_FIMC1
> >> > +#define S5P_PA_FIMC2 ? ? ? ? ? S5PV210_PA_FIMC2
> >> >
> >> > I mean it's just ordering.
> >>
> >> Yes I also mean it don't separate the related definitions. so place
> >> adjacent as the the previous.
> >>
> > No...maybe you misunderstood...hmm :-(
> > Please add in map.h of V210 like following.
> 
> Then please also apply the same rules at existing definitions.
> 
I meant...there are other orderings in a patch file..so unify style...
But..yeah, in this case the criteria about that seems not clear.
If need, I will sort it out...firstly please address as I said.

Marek, could you please re-submit for this...?

> >
> > @@ -110,6 +110,10 @@
> > ?#define S3C_PA_RTC ? ? ? ? ? ? S5PV210_PA_RTC
> > ?#define S3C_PA_WDT ? ? ? ? ? ? S5PV210_PA_WATCHDOG
> >
> > +#define S5P_PA_FIMC0 ? ? ? ? ? S5PV210_PA_FIMC0
> > +#define S5P_PA_FIMC1 ? ? ? ? ? S5PV210_PA_FIMC1
> > +#define S5P_PA_FIMC2 ? ? ? ? ? S5PV210_PA_FIMC2
> > +
> > ?#define SAMSUNG_PA_ADC ? ? ? ? S5PV210_PA_ADC
> > ?#define SAMSUNG_PA_CFCON ? ? ? ? ? ? ? S5PV210_PA_CFCON
> > ?#define SAMSUNG_PA_KEYPAD ? ? ? ? ? ? ?S5PV210_PA_KEYPAD
> >
> > (snip)
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
