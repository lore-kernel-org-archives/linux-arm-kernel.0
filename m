From: B19295@freescale.com (Lin Tony-B19295)
Date: Mon, 25 Jul 2011 10:43:25 +0000
Subject: [PATCH v2 3/6] ARM: mxs: add usb clocks to clock tree
In-Reply-To: <4E2D4445.80802@ru.mvista.com>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
	<1311577284-11506-4-git-send-email-tony.lin@freescale.com>
	<4E2D4445.80802@ru.mvista.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5165E1F@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Monday, July 25, 2011 6:24 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> stern at rowland.harvard.edu; koen.beel.barco at gmail.com
> Subject: Re: [PATCH v2 3/6] ARM: mxs: add usb clocks to clock tree
> 
> Hello.
> 
> On 25-07-2011 11:01, Tony Lin wrote:
> 
> > add usb host clock and usb host phy clock to clock tree add usb dummy
> > clocks to clock tree to get rid of adding more cpu_is_mx macros
> 
> > Signed-off-by: Tony Lin<tony.lin@freescale.com>
> > ---
> >   arch/arm/mach-mxs/clock-mx28.c |   28 +++++++++++++++++++---------
> >   1 files changed, 19 insertions(+), 9 deletions(-)
> 
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index 5dcc59d..6f3cd40 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -554,15 +554,15 @@ static struct clk rtc_clk = {
> >   	.parent =&ref_xtal_clk,
> >   };
> >
> > -/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
> > -static struct clk usb0_clk = {
> > -	.enable_reg = DIGCTRL_BASE_ADDR,
> > -	.enable_shift = 2,
> > -	.enable = _raw_clk_enable,
> > -	.disable = _raw_clk_disable,
> > -	.parent =&pll0_clk,
> > +static struct clk dummy_clk = {
> > +	.enable_reg = 0,
> > +	.enable_shift = 0,
> > +	.enable = NULL,
> > +	.disable = NULL,
> > +	.parent = NULL,
> 
>     You don't need to explicitly initialize to 0 or NULL.
> 
Okay.

> WBR, Sergei
