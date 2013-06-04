From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 4 Jun 2013 14:18:15 +0200
Subject: DT version of kirkwood_ge0x_init()
In-Reply-To: <20130604120500.GZ3803@titan.lakedaemon.net>
References: <51ADBEE0.5040500@keymile.com> <51ADC2C2.6010106@gmail.com>
 <20130604104302.GX3803@titan.lakedaemon.net>
 <20130604115927.GJ7626@kw.sim.vm.gnt>
 <20130604120500.GZ3803@titan.lakedaemon.net>
Message-ID: <20130604121815.GK7626@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 08:05:00AM -0400, Jason Cooper wrote:
> On Tue, Jun 04, 2013 at 01:59:27PM +0200, Simon Guinot wrote:
> > On Tue, Jun 04, 2013 at 06:43:02AM -0400, Jason Cooper wrote:
> > > On Tue, Jun 04, 2013 at 12:34:42PM +0200, Sebastian Hesselbarth wrote:
> > > > On 06/04/13 12:18, Gerlando Falauto wrote:
> > > > >I noticed how most of the DT-aware board-setup files only have a single
> > > > ><board>_init() function, calling kirkwood_ge00_init() with a struct
> > > > >mv643xx_eth_platform_data as a single argument.
> > > > >
> > > > >I was wondering -- is there a reason why we cannot remove all this
> > > > >board-specific code and move all this to the DT?
> > > > 
> > > > Gerlando,
> > > > 
> > > > DT for mv643xx_eth is on the way (https://lkml.org/lkml/2013/5/29/527).
> > > > We wait for the driver to surface to relax branch dependencies and then
> > > > move all DT Orion SoCs to it.
> > > > 
> > > > > I would really love to have all our boards under a single
> > > > > CONFIG_<FAMILY>_DT and a single compatible string, with all the
> > > > > differences within the DTs itself -- no more #ifdef CONFIG_<BOARD>,
> > > > > no more of_machine_is_compatible("boardXXX").
> > > > 
> > > > All those will happen if there is DT support for mv643xx_eth which
> > > > is the only driver left without DT and board dependencies. But there
> > > > will be no CONFIG_LACIE_DT or whatever, but just CONFIG_KIRKWOOD_DT
> > > > and board dependent stuff described in the corresponding dts.
> > > 
> > > Gerlando,
> > > 
> > > Yes, the mess you describe is temporary.  Those board files used to have
> > > a lot more code in them, legacy init of partitions, MPP, LEDs, etc.  As
> > > we have converted drivers, they have gotten smaller and smaller.
> > > 
> > > Now, with Sebastian's hard work, we'll finally be able to remove them
> > > and kirkwood will be completely DT.  We're very excited about this. :)
> > > 
> > > Next, we'll move the Marvell DT boards over to mach-mvebu/ and only
> > > legacy boards in -kirkwood/, -orion5x/, -dove/, and -mv78xx0/ will
> > > remain.  After a few releases we will deprecate any legacy boards which
> > > haven't been converted to DT.
> > 
> > Hi Jason,
> > 
> > While I have obviously planed to convert all the LaCie boards to DT,
> > I think that removing the legacy support so quickly is a little bit
> > harsh.
> 
> Yeah, my wording might not have been the best.  See below.
> 
> > IMHO, it could be nice to wait the end-of-life for all this products
> > before removing their support.
> 
> I'd prefer to convert them to DT, then keep them as long as folks are
> interested in them.  If no one cares about a board, and no one wants to
> convert it to DT or test the conversion, why keep it around?
> 
> Let me clarify, by 'deprecate them' I meant *begin* the process of
> deprecating them.  eg marking them as deprecated for around three
> releases or so.

OK. Thanks for the clarifications.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/0305b17c/attachment.sig>
