From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Sep 2010 10:09:08 +0100
Subject: [PATCH 13/74] ST SPEAr: Update clock framework and definitions
In-Reply-To: <4C85FF6A.5060904@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
	<20100906230931.GF8153@game.jcrosoft.org> <4C85B868.6040908@st.com>
	<20100907040641.GA30509@game.jcrosoft.org>
	<4C85FF6A.5060904@st.com>
Message-ID: <20100907090908.GA9978@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 07, 2010 at 02:31:30PM +0530, viresh kumar wrote:
> On 9/7/2010 9:36 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 09:28 Tue 07 Sep     , viresh kumar wrote:
> >> > On 9/7/2010 4:39 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>> > >>  /* array of all spear 13xx clock lookups */
> >>>>> > >> > @@ -327,18 +749,58 @@ static struct clk_lookup spear_clk_lookups[] = {
> >>>>> > >> >  	/* clock derived from pll1 clk */
> >>>>> > >> >  	{.con_id = "cpu_clk",		.clk = &cpu_clk},
> >>>>> > >> >  	{.con_id = "ahb_clk",		.clk = &ahb_clk},
> >>>>> > >> > -	{ .con_id = "apb_clk",		.clk = &apb_clk},
> >>>>> > >> > +	{.con_id = "apb_clk",		.clk = &apb_clk},
> >>>>> > >> > +
> >>> > > how about use macro here to simplify the code
> >>> > > 
> >>> > > +#define CLKDEV_ID(__clk) { .con_id = #__clk, .clk = &(__clk) }
> >>> > > and 
> >>> > > +#define CLKDEV_ID_CLK(__clk) { .con_id = #__clk, .clk = &(__clk##_clk) }
> >> > 
> >> > We had that in mind while designing but we chose it this way. There are
> >> > not many fields to fill here, so it looks fine without macro's too.
> >> > I didn't wanted to create an abstraction layer here.
> > the macro will also avoid human mistake
> 
> OK. Will do it in a separate patch.

I'd suggest leaving it as is - presumably its already been tested and
so works.

Adding that macro just encourages bad usage anyway - by encouraging
people to name individual clocks by their source rather than by their
consumer.  Naming clocks by their source has been proven many times to
make things more complicated and difficult in the long run.
