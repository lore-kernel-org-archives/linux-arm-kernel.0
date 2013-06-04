From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Jun 2013 06:43:02 -0400
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <51ADC2C2.6010106@gmail.com>
References: <51ADBEE0.5040500@keymile.com>
 <51ADC2C2.6010106@gmail.com>
Message-ID: <20130604104302.GX3803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 12:34:42PM +0200, Sebastian Hesselbarth wrote:
> On 06/04/13 12:18, Gerlando Falauto wrote:
> >I noticed how most of the DT-aware board-setup files only have a single
> ><board>_init() function, calling kirkwood_ge00_init() with a struct
> >mv643xx_eth_platform_data as a single argument.
> >
> >I was wondering -- is there a reason why we cannot remove all this
> >board-specific code and move all this to the DT?
> 
> Gerlando,
> 
> DT for mv643xx_eth is on the way (https://lkml.org/lkml/2013/5/29/527).
> We wait for the driver to surface to relax branch dependencies and then
> move all DT Orion SoCs to it.
> 
> > I would really love to have all our boards under a single
> > CONFIG_<FAMILY>_DT and a single compatible string, with all the
> > differences within the DTs itself -- no more #ifdef CONFIG_<BOARD>,
> > no more of_machine_is_compatible("boardXXX").
> 
> All those will happen if there is DT support for mv643xx_eth which
> is the only driver left without DT and board dependencies. But there
> will be no CONFIG_LACIE_DT or whatever, but just CONFIG_KIRKWOOD_DT
> and board dependent stuff described in the corresponding dts.

Gerlando,

Yes, the mess you describe is temporary.  Those board files used to have
a lot more code in them, legacy init of partitions, MPP, LEDs, etc.  As
we have converted drivers, they have gotten smaller and smaller.

Now, with Sebastian's hard work, we'll finally be able to remove them
and kirkwood will be completely DT.  We're very excited about this. :)

Next, we'll move the Marvell DT boards over to mach-mvebu/ and only
legacy boards in -kirkwood/, -orion5x/, -dove/, and -mv78xx0/ will
remain.  After a few releases we will deprecate any legacy boards which
haven't been converted to DT.

thx,

Jason.
