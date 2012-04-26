From: boojin.kim@samsung.com (Boojin Kim)
Date: Thu, 26 Apr 2012 16:35:40 +0900
Subject: [PATCH 0/4] memcpy optimized with strd/ldrd
In-Reply-To: <alpine.LFD.2.02.1204031047430.24151@xanadu.home>
References: <03e101cd0e07$eec39f10$cc4add30$@com>
 <030501cd0e6a$03642770$0a2c7650$%kim@samsung.com>
 <alpine.LFD.2.02.1203300914510.24151@xanadu.home>
 <008f01cd1170$cbee3dd0$63cab970$%kim@samsung.com>
 <alpine.LFD.2.02.1204031047430.24151@xanadu.home>
Message-ID: <016a01cd237f$2e2ecc10$8a8c6430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:
> Sent: Tuesday, April 03, 2012 11:49 PM
> To: Boojin Kim
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 0/4] memcpy optimized with strd/ldrd
>
> On Tue, 3 Apr 2012, Boojin Kim wrote:
>
> > Nicolas Pitre wrote:
> >
> > > > >
> > > > > Here's my version.  Lightly tested.
> > > > > I have no A15 hardware to run any performance comparison though.
> > > > >
> > > > I'm reviewing and testing your patch. But, My other work disturbs to reviewing it.
> > > > I will give you feedback soon within this week.
> > > > Wait a little more.
> > > > And, Thanks for your patches. :)
> > >
> > > FYI, it occurred to me that some corner cases might not be quite right
> > > with regards to alignment for the STRD instruction.  It seems that the
> > > hardware on which I tested it (Marvell Dove CPU) apparently copes with
> > > misaligned SDRD's when they're still 32-bit aligned.  So I need to run
> > > this code through a real validation harness on different hardware.
> >
> > It's sad, but the performance result wasn't better after adapting your patch.
> > I think something on 1~3 patch brings performance degreasing.
>
> If you could identify which patch is responsible that would be helpful.
Sorry for late response. I'm so busy these days. Y_Y
I checked your patches. And, the 1st patch makes performance drop.
Transmit time for 4KB memcpy is 489ns. After applying 1st patch, the transmit time is 578ns.
Performance also drops on memcpy of other small size about 10%.
I wish this is helpful for you.
Thanks,
>
> Thanks.
>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
