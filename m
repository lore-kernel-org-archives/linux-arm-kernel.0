From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 10 Aug 2013 14:34:21 +0200
Subject: [PATCH v6 09/11] clk: mmp: parse clock from dts
In-Reply-To: <20130810123123.GA18085@e106331-lin.cambridge.arm.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <2492085.mx8aBrGksJ@flatron>
 <20130810123123.GA18085@e106331-lin.cambridge.arm.com>
Message-ID: <2736667.dYaoNLt50m@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 of August 2013 13:31:23 Mark Rutland wrote:
> On Sat, Aug 10, 2013 at 12:06:01PM +0100, Tomasz Figa wrote:
> > Hi Mark, Haojian,
> > 
> > On Friday 09 of August 2013 17:04:01 Mark Rutland wrote:
> > > On Fri, Jul 26, 2013 at 11:05:31AM +0100, Haojian Zhuang wrote:
> > > > Parse clock information from DTS file for mach-mmp.
> > > > 
> > > > Changelog:
> > > > v6:
> > > > 1. Remove marvell string from properties in clock driver.
> > > > 2. Append document for clock binding device tree.
> > > > 3. Use apbc to replace apbcp. Since the main difference is
> > > > register
> > > > base.
> > > > 
> > > > v5:
> > > > 1. Replace clk_register_mux() by clk_register_mux_table().
> > > > 
> > > > Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/clock/mmp-clock.txt        |  51 ++++
> > > >  arch/arm/mach-mmp/mmp-dt.c                         |   2 +
> > > >  drivers/clk/mmp/Makefile                           |   2 +-
> > > >  drivers/clk/mmp/clk-mmp.c                          | 300
> > > >  +++++++++++++++++++++ 4 files changed, 354 insertions(+), 1
> > > >  deletion(-)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/clock/mmp-clock.txt create mode
> > > >  100644 drivers/clk/mmp/clk-mmp.c
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/mmp-clock.txt
> > > > b/Documentation/devicetree/bindings/clock/mmp-clock.txt new file
> > > > mode
> > > > 100644
> > > > index 0000000..5fe52a2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/mmp-clock.txt
> > > > @@ -0,0 +1,51 @@
> > > > +Device Tree Clock bindings for arch-mmp
> > > > +
> > > > +This binding uses the common clock binding[1].
> > > > +
> > > > +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > > > +
> > > 
> > > Are these used somewhere already?
> > 
> > Hmm? Are you asking about the generic clock bindings or I didn't get
> > your question right? They are supposed to be used (and they are used)
> > whenever clocks are involved.
> 
> Sorry, I meant are there any dts out there using these specific
> bindings? I wasn't sure how far upstream the series was, and wanted to
> make sure this hadn't gone upstream before I managed to reply.

OK, sorry for the noise then.

Best regards,
Tomasz
