From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Jul 2014 08:41:35 +0200
Subject: [PATCH 1/2] ARM: efm32: switch to properly namespaced location
 property
In-Reply-To: <CAOesGMjzzYwXKXZLvUVp-nAGf+R4G8eUjK+3CumB8i5LkoRCow@mail.gmail.com>
References: <20140630154030.GJ14781@pengutronix.de>
 <1404142889-20740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAOesGMjzzYwXKXZLvUVp-nAGf+R4G8eUjK+3CumB8i5LkoRCow@mail.gmail.com>
Message-ID: <20140708064135.GE7827@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Jul 07, 2014 at 10:46:52PM -0700, Olof Johansson wrote:
> On Mon, Jun 30, 2014 at 8:41 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Now that both spi and serial driver support these (commits f2bb31057a42
> > (spi: efm32: properly namespace location property) and
> > 74be65a3cff5 (serial: efm32: properly namespace location property)) use
> > the better names.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/efm32gg-dk3750.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
> > index b4031fa4a567..d5dd2a2a7970 100644
> > --- a/arch/arm/boot/dts/efm32gg-dk3750.dts
> > +++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
> > @@ -43,7 +43,7 @@
> >
> >                 spi0: spi at 4000c000 { /* USART0 */
> >                         cs-gpios = <&gpio 68 1>; // E4
> > -                       location = <1>;
> > +                       efm32,location = <1>;
> 
> Hrm, the prefix is normally the vendor, not the platform. I see that
Don't considering what it used normally (and I didn't do it wrong on
purpose) I consider a string identifying the platform to be more
sensible here. For one thing because the vendor can change (as it did with
efm32). Another reason is that the vendor can create another platform
that also needs some devices with a location property that has a
completely different semantic but would get the same name.
(Ok, if the semantic on the different platform is similar
$vendor,location would be more appropriate. Probably the decision on
what name to pick should be considered case by case.)

Just my 0.02 ?,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
