From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 9 Mar 2012 15:44:31 +0100
Subject: [RFC] i.MX: drop secondary clocks
In-Reply-To: <20120309142205.GF3852@pengutronix.de>
References: <1331242949-22780-1-git-send-email-s.hauer@pengutronix.de>
 <20313.52782.832292.580932@ipc1.ka-ro>
 <20120309102931.GY3852@pengutronix.de>
 <20313.60910.420339.905973@ipc1.ka-ro>
 <20120309142205.GF3852@pengutronix.de>
Message-ID: <20314.5967.278184.187691@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> On Fri, Mar 09, 2012 at 12:47:58PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Sascha Hauer writes:
> > > On Fri, Mar 09, 2012 at 10:32:30AM +0100, Lothar Wa?mann wrote:
> > > > Hi,
> > > > 
> > > > Sascha Hauer writes:
> > > > > Hi All,
> > > > > 
> > [...]
> > > > I think that's a bad idea! Drivers should not have to know intimate
> > > > details about the clock logic of the CPU core they are running on!
> > > 
> > > They don't have to. There really are different clocks connected to the
> > > devices. If for example you have a look eSDHC Block diagram in the
> > > reference Manual  you'll see that this has three clock inputs. All
> > > we do is to tell the driver about these three clocks which are device
> > > specific and not SoC specific. Which of these clocks are actually
> > > gatetable varies from SoC to SoC. Also on some SoCs two of the three
> > > clocks may be actually the same.
> > > 
> > At least this should be done in a way that is independent from the
> > name of the clock on a specific SoC, but is related to the function of
> > the clock for the driver. Thus instead of e.g. CLK_IPG and CLK_PER use
> > CLK_REG and CLK_BITRATE.
> 
> 'per', 'ipg' and 'ahb' seems to be a common pattern with all i.MXs. Only
> ahb is sometimes refered to as hclk. Do you also have a name for
> ahb/hclk? I don't insist on specific names, in the end they are just
> names and the pattern I used at least seems mostly consistent.
> 
CLK_BUS?

> I assume that any given device has a set of clocks as inputs which
> should get device specific names. It's the job of the clock tree
> to know which SoC clocks map to which device clocks. If now a newer
> UART block has an additional clock, then we would depending on the
> device id (fsl,imx7-uart) know that it requires the additional clock
> and request it.
> 
It's also not the business of a device driver to know any details
about clock dependencies on a specific SoC.
We probably really need a bus layer that can hide the details of the
bus architecture and their corresponding clocks from the device
drivers.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
