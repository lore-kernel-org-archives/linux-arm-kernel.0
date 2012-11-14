From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 14 Nov 2012 15:12:54 +0000
Subject: [PATCH v2 2/5] clk: Add support for fundamental zynq clks
In-Reply-To: <20121113220257.GN1718@beefymiracle.amer.corp.natinst.com>
References: <cover.1352400580.git.josh.cartwright@ni.com>
 <3569f4619a92904a40aecc9300aafe767ac736f7.1352400580.git.josh.cartwright@ni.com>
 <df95297d-a875-464a-b7a1-c494f2522a43@CO1EHSMHS027.ehs.local>
 <20121113220257.GN1718@beefymiracle.amer.corp.natinst.com>
Message-ID: <4d134063-467e-4ae9-9070-e45d5dc11c36@CH1EHSMHS010.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Tuesday, November 13, 2012 11:03 PM
> To: Soren Brinkmann; Michal Simek
> Cc: Mike Turquette; Rob Herring; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; John Linn; arm at kernel.org
> Subject: Re: [PATCH v2 2/5] clk: Add support for fundamental zynq clks
>
> On Thu, Nov 08, 2012 at 03:28:07PM -0800, Soren Brinkmann wrote:
> > One note below:
> >
> > On Wed, Oct 31, 2012 at 12:58:52PM -0600, Josh Cartwright wrote:
> [..]
> > > --- /dev/null
> > > +++ b/drivers/clk/clk-zynq.c
> [..]
> > > +struct zynq_periph_clk {
> > > + struct clk_hw           hw;
> > > + struct clk_onecell_data onecell_data;
> > > + struct clk              *gates[2];
> > > + void __iomem            *clk_ctrl;
> > > + spinlock_t              clkact_lock;
> > > +};
> > > +
> > > +#define to_zynq_periph_clk(hw)   container_of(hw, struct zynq_periph_clk,
> hw)
> > > +
> > > +static const u8 periph_clk_parent_map[] = {
> > > + 0, 0, 1, 2
> > > +};
> > > +#define PERIPH_CLK_CTRL_SRC(x)   (periph_clk_parent_map[((x) & 3) >> 4])
> >
> > I think this should be:
> > #define PERIPH_CLK_CTRL_SRC(x)      (periph_clk_parent_map[((x) & 0x30) >>
> 4])
>
> Yes indeed it should be, thanks.
>
> Michal-  I'll just be following up with a v3 of this patch instead of spinning up the
> whole set to save myself some time.  If you'd rather I spin up the whole set, let
> me know.


No problem with that.

thanks,
Michal


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
