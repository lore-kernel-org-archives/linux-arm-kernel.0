From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Jun 2013 15:27:55 +0100
Subject: [PATCH 08/21] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <2199337.TqRF93pcHr@wuerfel>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <1370266965-7901-9-git-send-email-lee.jones@linaro.org>
 <2199337.TqRF93pcHr@wuerfel>
Message-ID: <20130603142755.GH3370@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 03 Jun 2013, Arnd Bergmann wrote:

> On Monday 03 June 2013 14:42:32 Lee Jones wrote:
> > @@ -559,6 +559,8 @@
> >                         v-i2c-supply = <&db8500_vape_reg>;
> >  
> >                         clock-frequency = <400000>;
> > +                       clocks = <&clk 100>, <&clk 67>;
> > +                       clock-names = "nmk-i2c.0", "apb_pclk";
> >                 };
> >  
> >                 i2c at 80122000 {
> > @@ -572,6 +574,9 @@
> >                         v-i2c-supply = <&db8500_vape_reg>;
> >  
> >                         clock-frequency = <400000>;
> > +
> > +                       clocks = <&clk 85>, <&clk 42>;
> > +                       clock-names = "nmk-i2c.1", "apb_pclk";
> >                 };
> 
> Same comment actually as for the uart patch, also SDI and MSP
> have the same problem.

I was only using the names in the same manor as the API does, to fetch
the 'clocks =' index. Do you mean that I should be using 'uartclk',
'i2cclk', 'sdmmcclk' and 'msp1clk' instead?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
