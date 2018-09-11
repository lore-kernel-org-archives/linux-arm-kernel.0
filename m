From: lkundrak@v3.sk (Lubomir Rintel)
Date: Tue, 11 Sep 2018 14:55:27 +0200
Subject: [PATCH] DT: marvell,mmp2: add MMC controllers
In-Reply-To: <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
References: <20180910120243.163979-1-lkundrak@v3.sk>
 <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
Message-ID: <4892b137e9ba100fea7d9d9c7d401d81f33271a7.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-09-10 at 10:14 -0500, Rob Herring wrote:
> On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > 
> > There's apparently four of them on a MMP2.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  arch/arm/boot/dts/mmp2.dtsi | 40
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mmp2.dtsi
> > b/arch/arm/boot/dts/mmp2.dtsi
> > index 766bbb8495b6..51d4a2d70db9 100644
> > --- a/arch/arm/boot/dts/mmp2.dtsi
> > +++ b/arch/arm/boot/dts/mmp2.dtsi
> > @@ -18,6 +18,10 @@
> >                 serial3 = &uart4;
> >                 i2c0 = &twsi1;
> >                 i2c1 = &twsi2;
> > +               sdhci0 = &mmc1;
> > +               sdhci1 = &mmc2;
> > +               sdhci2 = &mmc3;
> > +               sdhci3 = &mmc4;
> 
> Please drop this. MMC nodes don't need an alias and if they did,
> "sdhci" wouldn't be the name.

Will do. I essentially just cargo-culted this, because I had no idea
which devices need aliases. How do I decide whether an alias is needed?

> 
> Rob

Thank you,
Lubo
