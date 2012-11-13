From: josh.cartwright@ni.com (Josh Cartwright)
Date: Tue, 13 Nov 2012 16:02:57 -0600
Subject: [PATCH v2 2/5] clk: Add support for fundamental zynq clks
In-Reply-To: <df95297d-a875-464a-b7a1-c494f2522a43@CO1EHSMHS027.ehs.local>
References: <cover.1352400580.git.josh.cartwright@ni.com>
 <3569f4619a92904a40aecc9300aafe767ac736f7.1352400580.git.josh.cartwright@ni.com>
 <df95297d-a875-464a-b7a1-c494f2522a43@CO1EHSMHS027.ehs.local>
Message-ID: <20121113220257.GN1718@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 03:28:07PM -0800, Soren Brinkmann wrote:
> One note below:
>
> On Wed, Oct 31, 2012 at 12:58:52PM -0600, Josh Cartwright wrote:
[..]
> > --- /dev/null
> > +++ b/drivers/clk/clk-zynq.c
[..]
> > +struct zynq_periph_clk {
> > +	struct clk_hw		hw;
> > +	struct clk_onecell_data	onecell_data;
> > +	struct clk		*gates[2];
> > +	void __iomem		*clk_ctrl;
> > +	spinlock_t		clkact_lock;
> > +};
> > +
> > +#define to_zynq_periph_clk(hw)	container_of(hw, struct zynq_periph_clk, hw)
> > +
> > +static const u8 periph_clk_parent_map[] = {
> > +	0, 0, 1, 2
> > +};
> > +#define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x) & 3) >> 4])
>
> I think this should be:
> #define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x) & 0x30) >> 4])

Yes indeed it should be, thanks.

Michal-  I'll just be following up with a v3 of this patch instead of
spinning up the whole set to save myself some time.  If you'd rather I
spin up the whole set, let me know.

Thanks,

  Josh
