From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Jun 2013 17:29:52 +0200
Subject: [PATCH 08/21] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <20130603142755.GH3370@gmail.com>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <2199337.TqRF93pcHr@wuerfel> <20130603142755.GH3370@gmail.com>
Message-ID: <2173992.VOFqBIP467@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013 15:27:55 Lee Jones wrote:
> On Mon, 03 Jun 2013, Arnd Bergmann wrote:
> 
> > On Monday 03 June 2013 14:42:32 Lee Jones wrote:
> > > @@ -559,6 +559,8 @@
> > >                         v-i2c-supply = <&db8500_vape_reg>;
> > >  
> > >                         clock-frequency = <400000>;
> > > +                       clocks = <&clk 100>, <&clk 67>;
> > > +                       clock-names = "nmk-i2c.0", "apb_pclk";
> > >                 };
> > >  
> > >                 i2c at 80122000 {
> > > @@ -572,6 +574,9 @@
> > >                         v-i2c-supply = <&db8500_vape_reg>;
> > >  
> > >                         clock-frequency = <400000>;
> > > +
> > > +                       clocks = <&clk 85>, <&clk 42>;
> > > +                       clock-names = "nmk-i2c.1", "apb_pclk";
> > >                 };
> > 
> > Same comment actually as for the uart patch, also SDI and MSP
> > have the same problem.
> 
> I was only using the names in the same manor as the API does, to fetch
> the 'clocks =' index. Do you mean that I should be using 'uartclk',
> 'i2cclk', 'sdmmcclk' and 'msp1clk' instead?

Yes, that would be better. I suppose you can actually leave out the
'clk' part and just call them 'i2c', 'sdmmc', 'msp' and 'uart',
but you should check if any of the driver already specify the
clock names in their DT bindings.

	Arnd
