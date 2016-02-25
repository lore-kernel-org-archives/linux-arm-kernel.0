From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 25 Feb 2016 20:08:17 +0100
Subject: [PATCH v3] mtd: atmel_nand: move the hsmc_clk from nfc node to
 nand node
In-Reply-To: <20160225183139.GL21465@google.com>
References: <1456207220-7757-1-git-send-email-wenyou.yang@atmel.com>
 <56CC393B.6090801@atmel.com> <20160225183139.GL21465@google.com>
Message-ID: <20160225190817.GK12073@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/02/2016 at 10:31:39 -0800, Brian Norris wrote :
> + devicetree, Boris
> 
> Convenient you left devicetree off, since I expect you'd get a hearty NAK
> from them...
> 
> On Tue, Feb 23, 2016 at 11:49:31AM +0100, Nicolas Ferre wrote:
> > Le 23/02/2016 07:00, Wenyou Yang a ?crit :
> > > From: Josh Wu <josh.wu@atmel.com>
> > > 
> > > For SAMA5D3, SAMA5D4 SoC family, PMECC becomes a part of HSMC, they
> > > need the HSMC clock enabled to work.
> > > The NFC is a sub feature for current nand driver, it can be disabled.
> > > But if HSMC clock is controlled by NFC, so disable NFC will also disable
> > > the HSMC clock. then, it will make the PMECC fail to work.
> > > 
> > > So the solution is move the HSMC clock out of NFC to nand node. When
> > > nand driver probed, it will check whether the chip has HSMC, if yes then
> > > it will require a HSMC clock.
> > > 
> > > Add a new "atmel,sama5d3-nand" compatiable string for SAMA5D3's nand.
> > > 
> > > Signed-off-by: Josh Wu <josh.wu@atmel.com>
> > > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > > ---
> > > 
> > > Changes in v3:
> > >  - add "atmel,sama5d3-nand" compatiable string for SAMA5D3's nand.
> > >  - revert the mail address of Josh's Signed-off to the original.
> > 
> > It seems okay now:
> > Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Brian, can we take this patch (if you acknowledged it) with us (through
> > the arm-soc tree) to keep the synchronization with the DT part of this work?
> > I will also consider squashing the DT part in this one as well as they
> > cannot be separated.
> 
> Doesn't that mean you have an illegal breakage of the device tree?
> 
> Also, if you're going to refactor the binding (and possibly even break
> it like this), why don't you address the comments Boris made back on the
> first version about a year ago?
> 
> http://patchwork.ozlabs.org/patch/438211/
> 
> Particularly, I agree that you seem to have the sub-node relationship
> all backward. Why is the controller a sub-node of the flash node? And
> you have no provision for multiple NAND chips?
> 

Yes, we plan to break that binding even more, we don't have much choice.
I would agree that it would be better to break it only once though.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
