From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Fri, 3 Sep 2010 10:49:09 +0200
Subject: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
In-Reply-To: <20100902172908.GD2464@tarshish>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<20100902145357.GL14214@pengutronix.de>
	<19583.48828.125104.712979@ipc1.ka-ro>
	<20100902172908.GD2464@tarshish>
Message-ID: <19584.46725.955202.942529@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Thu, Sep 02, 2010 at 05:11:56PM +0200, Lothar Wa?mann wrote:
> > > > -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> > > > +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers are
> > > > +	 * not compatible with existing SPI controllers on other i.MX platforms,
> > > > +	 * while CSPI controller is 100% compatible with the one on the i.MX35.
> > > > +	 * We set the platform device id to 2 for this CSPI at i.MX51 board init
> > > > +	 * level to distinguish it from two eCSPI controllers.
> > > > +	 */
> > > This comment is missing in Sascha's driver.  I like it.
> > > BTW, I'd like to make use of platform ids in this driver.  This would
> > > make this ugly "on imx51 id2 is a cspi" distinction unnecessary.
> > > 
> > > > +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> > > > +	    (cpu_is_mx51() && (pdev->id == 2))) {
> > I'd prefer a flag in the platform_data that tells the driver to act as
> > an eCSPI driver. This way the information about eCSPI or not would be
> > where it belongs (in the arch specific code).
> 
> But this also increases the size of driver code, since the compiler can 
> resolve cpu_is_* at compile time, and drop the dead code. Maybe an is_ecspi 
> macro will make the above code clearer.
> 
I did not mean to remove the cpu_is_* macros, but use the explicit
ecspi flag instead of the comparison with pdev->id.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
