From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Aug 2013 11:30:34 +0200
Subject: [PATCH 09/33] ARM: ux500: Supply the I2C clocks lookup to the
 DBX500 DT
In-Reply-To: <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
References: <1370521041-32318-1-git-send-email-lee.jones@linaro.org>
 <1370521041-32318-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdbE86HgPr+7LZD9BFU_OsDFFFWTaFHW_i2fNXivKZ-3Dw@mail.gmail.com>
Message-ID: <20130820093034.GL31036@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 11:11:19AM +0200, Linus Walleij wrote:
> On Thu, Jun 6, 2013 at 2:16 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > +++ b/arch/arm/boot/dts/dbx5x0.dtsi
> > @@ -572,6 +572,8 @@
> >                         v-i2c-supply = <&db8500_vape_reg>;
> >
> >                         clock-frequency = <400000>;
> > +                       clocks = <&prcc_kclk 3 3>, <&prcc_pclk 3 3>;
> > +                       clock-names = "nmk-i2c.0", "apb_pclk";

Why do most clocks in this series have the instance number in the clock
names? This looks very wrong to me.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
