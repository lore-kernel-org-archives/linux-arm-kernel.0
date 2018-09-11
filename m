From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 11 Sep 2018 08:23:42 -0500
Subject: [PATCH] DT: marvell,mmp2: add MMC controllers
In-Reply-To: <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
References: <20180910120243.163979-1-lkundrak@v3.sk>
 <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
 <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
Message-ID: <CAL_JsqKmfuc7V2J0pzonj+uKfgpvc_DwnpGYQJ1iJ5SpGSpo9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 7:55 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Mon, 2018-09-10 at 10:14 -0500, Rob Herring wrote:
> > On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk>
> > wrote:
> > >
> > > There's apparently four of them on a MMP2.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  arch/arm/boot/dts/mmp2.dtsi | 40
> > > +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/mmp2.dtsi
> > > b/arch/arm/boot/dts/mmp2.dtsi
> > > index 766bbb8495b6..51d4a2d70db9 100644
> > > --- a/arch/arm/boot/dts/mmp2.dtsi
> > > +++ b/arch/arm/boot/dts/mmp2.dtsi
> > > @@ -18,6 +18,10 @@
> > >                 serial3 = &uart4;
> > >                 i2c0 = &twsi1;
> > >                 i2c1 = &twsi2;
> > > +               sdhci0 = &mmc1;
> > > +               sdhci1 = &mmc2;
> > > +               sdhci2 = &mmc3;
> > > +               sdhci3 = &mmc4;
> >
> > Please drop this. MMC nodes don't need an alias and if they did,
> > "sdhci" wouldn't be the name.
>
> Will do. I essentially just cargo-culted this, because I had no idea
> which devices need aliases. How do I decide whether an alias is needed?

Add them when you find that you actually need them.

Serial to get stable tty names. It used to be for the console too, but
stdout-path property should be used instead.
ethernet for u-boot to determine which interface to net boot from (IIRC).
i2c and spi are also for stable /dev names, but that should be handled
another way IMO. You can find discussions about it in the archives.

Anything else is probably questionable.

Rob
