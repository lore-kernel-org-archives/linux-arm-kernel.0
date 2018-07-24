From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 21:40:49 +0200
Subject: [RFT v2 00/10] pinctrl: samsung: Remove ugly hack for sharing
 eint_wakeup_mask
In-Reply-To: <20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l@eucas1p2.samsung.com>
References: <CGME20180723175334epcas5p3e46820b4d356d4f1ea718ec1a6c093a6@epcas5p3.samsung.com>
 <20180723175302.22535-1-krzk@kernel.org>
 <20180724091816eucas1p29790b3c45492b261ff154db8056fbb88~EQ2otAHnr1142511425eucas1p2l@eucas1p2.samsung.com>
Message-ID: <20180724194049.fpp5hi7hfy5w5mjj@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 11:18:13AM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-07-23 19:52, Krzysztof Kozlowski wrote:
> > Hi All,
> >
> > Changes since v1
> > ================
> > 1. Add Tomasz's ack.
> > 2. Reword description in patch 6/10.
> >
> >
> > Tests
> > =====
> > This is both request for comments and requests for tests. Only basic
> > tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
> > with max7768 RTC wakeup. Please kindly test it with devices capable of
> > suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
> > Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
> > broken however changing external interrupt wakeup mask was not done
> > on Exynos5433.
> 
> Works fine on Exynos5433 TM2 with some additional patches related to
> suspend/resume handling of the PMU. It handles only EINT0..EINT31 pins
> for now. Exynos5433 has more external interrupt wakeup lines: EINT32-63
> located at banks GPF1[0..7], GPF2[0..3], GPF3[0..3], GPF4[0..7] and
> GPF5[0..7]. They can be configured as wakeup sources in
> EXYNOS5433_EINT_WAKEUP_MASK1 (0x062C) PMU register. Handling of them
> can be added later when it will be really needed.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for comments and testing. Indeed support for Exynos5433 has to be
improved.

I would like to push 1-6 (which are needed for the rest) through current
cycle so I applied them to samsung-pinctrl tree.

Since anyway suspend to RAM is mostly broken nowadays... nothing more
should pop up.


Best regards,
Krzysztof
