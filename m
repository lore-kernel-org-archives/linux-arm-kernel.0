From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 19 Mar 2015 11:30:43 +0200
Subject: [PATCH 2/2] i2c: driver for the Conexant Digicolor I2C controller
In-Reply-To: <20150318210730.GA12960@katana>
References: <7da767503ac6085c10fbd1953ffd36621b8bf0c5.1424092804.git.baruch@tkos.co.il>
 <a106023efa9fd648f46021cd063437df798528de.1424092804.git.baruch@tkos.co.il>
 <20150318210730.GA12960@katana>
Message-ID: <20150319093042.GB2415@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wed, Mar 18, 2015 at 10:07:30PM +0100, Wolfram Sang wrote:
> On Mon, Feb 16, 2015 at 03:20:04PM +0200, Baruch Siach wrote:
> > This commit adds a driver for the I2C master controller on the CX92755 SoC. The
> > CX92755 is one SoC in the Conexant Digicolor series. This driver should support
> > other SoCs from that series.
> > 
> > Only 7bit slave addresses are currently supported.
> > 
> > Tested on the Equinox CX92755 EVK, using i2c-tools utilities to read and write
> > the on-chip (sic) audio codec.
> > 
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> 
> Looks mostly good.
> 
> > +static u32 dc_i2c_func(struct i2c_adapter *adap)
> > +{
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> > +}
> 
> You probably want to advertise I2C_FUNC_NOSTART here, too?

OK.

> And if you could rebase to something after 4.0-rc1, that would be much
> appreciated.

Did that some time ago along with the rest of my queue for that platform. Just 
waited for some review before reposting.

Thanks for reviewing,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
