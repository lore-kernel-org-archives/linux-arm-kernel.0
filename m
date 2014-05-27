From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 27 May 2014 09:19:23 +0200
Subject: [PATCH] clk: samsung: clk-s3c2410-dlck: do not use PNAME macro as
 it declares __initdata
In-Reply-To: <20140526212119.GP27093@quad.lixom.net>
References: <4598341.WkbLY9yLfe@phil> <20140526212119.GP27093@quad.lixom.net>
Message-ID: <4853638.CjtZR7iKXH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. Mai 2014, 14:21:19 schrieb Olof Johansson:
> On Fri, May 23, 2014 at 10:58:53PM +0200, Heiko St?bner wrote:
> > The originally used PNAME macro from the core samsung clock infrastructure
> > declares the created array as initdata, creating section mismatch warnings
> > in the dclk driver.
> > 
> > Thus declare them directly, removing these warning.
> > 
> > Reported-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > This should probably go though the samsung tree / arm-soc, as the
> > offending patch is also in there.
> > 
> >  drivers/clk/samsung/clk-s3c2410-dclk.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c
> > b/drivers/clk/samsung/clk-s3c2410-dclk.c index 8d8dff0..c1726f4 100644
> > --- a/drivers/clk/samsung/clk-s3c2410-dclk.c
> > +++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
> > @@ -135,26 +135,26 @@ struct s3c24xx_dclk {
> > 
> >  #define to_s3c24xx_dclk1(x) \
> >  
> >  		container_of(x, struct s3c24xx_dclk, dclk1_div_change_nb)
> > 
> > -PNAME(dclk_s3c2410_p) = { "pclk", "uclk" };
> > -PNAME(clkout0_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
> > +static const char *dclk_s3c2410_p[] = { "pclk", "uclk" };
> > +static const char *clkout0_s3c2410_p[] = { "mpll", "upll", "fclk",
> > "hclk", "pclk",> 
> >  			     "gate_dclk0" };
> > 
> > -PNAME(clkout1_s3c2410_p) = { "mpll", "upll", "fclk", "hclk", "pclk",
> > +static const char *clkout1_s3c2410_p[] = { "mpll", "upll", "fclk",
> > "hclk", "pclk",> 
> >  			     "gate_dclk1" };
> > 
> > -PNAME(clkout0_s3c2412_p) = { "mpll", "upll", "rtc_clkout",
> > +static const char *clkout0_s3c2412_p[] = { "mpll", "upll", "rtc_clkout",
> > 
> >  			     "hclk", "pclk", "gate_dclk0" };
> > 
> > -PNAME(clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk", "pclk",
> > +static const char *clkout1_s3c2412_p) = { "xti", "upll", "fclk", "hclk",
> > "pclk",> 
> >  			     "gate_dclk1" };
> 
> Fixed up this error in a separate commit, since it caused a build failure.
> 
> In other words, please build test your fixes before you send them. :)

sorry about that. I was so sure I did build test it, but when checking again 
now it in fact didn't build.


So sorry again
Heiko
