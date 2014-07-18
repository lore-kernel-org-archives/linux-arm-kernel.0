From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Jul 2014 13:16:53 +0200
Subject: [PATCHv6 1/4] iio: adc: exynos_adc: Add exynos_adc_data structure
 to improve readability
In-Reply-To: <CAHfPSqBDOEH5HurG=rECV=d+MM_YjTEpsiwuTgtNgFgCQ0P2bw@mail.gmail.com>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com>
 <6186153.TIYp5NXPIq@wuerfel>
 <CAHfPSqBDOEH5HurG=rECV=d+MM_YjTEpsiwuTgtNgFgCQ0P2bw@mail.gmail.com>
Message-ID: <237819296.s52Lu0h5nW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 July 2014 15:41:27 Naveen Krishna Ch wrote:
> >
> >         {
> >                 .name           = "s3c24xx-adc",
> >                 .driver_data    = TYPE_ADCV1,
> >         }, {
> >                 .name           = "s3c2443-adc",
> >                 .driver_data    = TYPE_ADCV11,
> >         }, {
> >                 .name           = "s3c2416-adc",
> >                 .driver_data    = TYPE_ADCV12,
> >         }, {
> >                 .name           = "s3c64xx-adc",
> >                 .driver_data    = TYPE_ADCV2,
> >         }, {
> >                 .name           = "samsung-adc-v3",
> >                 .driver_data    = TYPE_ADCV3,
> >         }
> >
> > Where TYPE_ADCV3 seems to be the same as the new ADC_V1 used in this
> > driver. Do you have an explanation for that?
> 
> As per suggestion from Doug Anderson,
> I've implemented IIO based ADC driver to work with Exynos5250.
> keeping the plat-samsung/adc.c unchanged.
> 
> Assuming Exynos5250 is the one using the driver for the first time.
> i've named it v1 and so on.
> 
> Now, This seems to cause a lot of confusion.

Ah, so the version numbers don't come from Samsung hardware
documents but are just counting the versions we have drivers
for?

In this case, I guess using the first SoC that had a particular
version would have been better, and we should probably do that
when we add support for the older hardware in this driver.

	Arnd
